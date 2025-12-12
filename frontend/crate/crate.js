import { API_BASE_URL } from "./config.js";

const nameInput = document.getElementById("crateName");
const urlInput = document.getElementById("playlistUrl");
const rawInput = document.getElementById("rawTracks");
const genBtn = document.getElementById("crateBtn");
const dlBtn = document.getElementById("downloadCrateBtn");
const summary = document.getElementById("crateSummary");

// Manifest UI (these exist only if you added them in crate/index.html)
const likeSeed = document.getElementById("likeSeed");
const similarityStrict = document.getElementById("similarityStrict");
const wContinuous = document.getElementById("wContinuous");
const wRemixEthics = document.getElementById("wRemixEthics");
const wDynamics = document.getElementById("wDynamics");
const wOrchestration = document.getElementById("wOrchestration");
const wSpeech = document.getElementById("wSpeech");
const wTruth = document.getElementById("wTruth");
const downloadManifestBtn = document.getElementById("downloadManifestBtn");

const makeCandidatesBtn = document.getElementById("makeCandidatesBtn");
const candidatesOut = document.getElementById("candidatesOut");

let lastCrate = null;

function buildManifest() {
  return {
    crate_name: nameInput?.value || "Untitled Crate",
    like_seed: likeSeed?.value || null,
    similarity_strictness: Number(similarityStrict?.value ?? 60),
    rule_weights: {
      continuous_build: Number(wContinuous?.value ?? 85),
      remix_ethics: Number(wRemixEthics?.value ?? 80),
      dynamics: Number(wDynamics?.value ?? 75),
      digital_orchestration: Number(wOrchestration?.value ?? 70),
      speech_over_singing: Number(wSpeech?.value ?? 65),
      truth_over_shine: Number(wTruth?.value ?? 90),
    },
    notes: "CrateJuice Studio – Music 11 Manifest (v1)",
  };
}

function downloadManifest() {
  const manifest = buildManifest();
  const blob = new Blob([JSON.stringify(manifest, null, 2)], {
    type: "application/json",
  });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${manifest.crate_name || "crate"}-manifest.json`;
  a.click();
  URL.revokeObjectURL(url);
}

downloadManifestBtn?.addEventListener("click", downloadManifest);

function make10Candidates(manifest) {
  const seed = (manifest.like_seed || "your seed").trim();
  const s = manifest.similarity_strictness;

  const w = manifest.rule_weights || {};
  const tags = [];

  if (w.continuous_build >= 70) tags.push("continuous-build", "no-chorus-reset");
  if (w.remix_ethics >= 70) tags.push("classic-DNA-nods", "no-nostalgia-cosplay");
  if (w.dynamics >= 70) tags.push("dynamic-range", "not-brickwalled");
  if (w.digital_orchestration >= 70) tags.push("digital-orchestration", "layered-sounddesign");
  if (w.speech_over_singing >= 70) tags.push("speech-drops", "found-voice");
  if (w.truth_over_shine >= 70) tags.push("truth-over-shine", "lofi-real");

  const strictWord =
    s >= 80 ? "very close to" : s >= 55 ? "in the world of" : "loosely inspired by";

  const prompts = [
    `Find tracks ${strictWord} "${seed}" with ${tags.join(", ")}.`,
    `Search: "${seed}" + "edit" + "continuous mix" (avoid big drops).`,
    `Search: "${seed}" + "rework" + "extended" + "no chorus".`,
    `Find a version of "${seed}" that uses subtle classic beat nods (James Brown-style snap / funk ghost).`,
    `Hunt for a darker/smarter sibling of "${seed}" with spoken emotional fragments.`,
    `Find a slow swagger cut like "${seed}" with real instrument samples + breathing dynamics.`,
    `Look for producers/remixers adjacent to "${seed}" (credits / remixer rabbit holes).`,
    `Search: "${seed}" + "live session" + "radio rip" (but keep it clean + musical).`,
    `Find an underground/low-playcount twin of "${seed}" that builds until the end.`,
    `Final filter: Avoid pop structure AND keep it truthful. If not, bin it.`,
  ];

  return prompts.map((p, i) => `${i + 1}. ${p}`);
}

makeCandidatesBtn?.addEventListener("click", () => {
  const manifest = buildManifest();
  const list = make10Candidates(manifest);
  if (candidatesOut) candidatesOut.textContent = list.join("\n");
});

function parseTrackLine(line) {
  const raw = line.trim();
  if (!raw) return null;

  let artist = "";
  let title = raw;

  if (raw.includes(" - ")) {
    [artist, title] = raw.split(" - ", 2);
  } else if (raw.includes("-")) {
    [artist, title] = raw.split("-", 2);
  }

  return { artist: (artist || "").trim(), title: (title || "").trim(), raw };
}

async function generateCrate() {
  const rawTracks = rawInput.value.trim();
  if (!rawTracks) {
    summary.textContent = "No tracks provided yet.";
    return;
  }

  const payload = {
    name: nameInput.value || null,
    playlist_url: urlInput.value || null,
    raw_tracks: rawTracks,
  };

  try {
    summary.textContent = "Stacking crate…";

    const resp = await fetch(`${API_BASE_URL}/api/crate/ingest`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });

    if (!resp.ok) {
      summary.textContent = `Error from backend: ${resp.status}`;
      dlBtn.disabled = true;
      return;
    }

    const data = await resp.json();

    // attach manifest (your Music 11 brain)
    data.manifest = buildManifest();

    lastCrate = data;

    const lines = [
      `Crate: ${data.crate_name}`,
      data.playlist_url ? `Playlist: ${data.playlist_url}` : "",
      `Tracks: ${data.track_count}`,
      "",
      ...data.tracks.map(
        (t, i) => `${i + 1}. ${t.artist ? t.artist + " - " : ""}${t.title}`
      ),
    ].filter(Boolean);

    summary.textContent = lines.join("\n");
    dlBtn.disabled = false;
  } catch (err) {
    console.error(err);
    summary.textContent = "Error talking to backend; check connection.";
    dlBtn.disabled = true;
  }
}

function downloadCrate() {
  if (!lastCrate) return;
  const blob = new Blob([JSON.stringify(lastCrate, null, 2)], {
    type: "application/json",
  });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${lastCrate.crate_name || "crate"}.json`;
  a.click();
  URL.revokeObjectURL(url);
}

genBtn.addEventListener("click", generateCrate);
dlBtn.addEventListener("click", downloadCrate);
