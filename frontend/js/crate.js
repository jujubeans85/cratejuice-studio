<<<<<<< HEAD
import { API_BASE_URL } from "./config.js";

const nameInput = document.getElementById("crateName");
const urlInput = document.getElementById("playlistUrl");
const rawInput = document.getElementById("rawTracks");
const genBtn = document.getElementById("crateBtn");
const dlBtn = document.getElementById("downloadCrateBtn");
const summary = document.getElementById("crateSummary");

let lastCrate = null;

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
=======
import { CJ_VERSION } from "/js/config.js";

const rawTracks = document.getElementById("rawTracks");
const out = document.getElementById("crateOut");
const status = document.getElementById("crateStatus");
const voiceStatus = document.getElementById("voiceStatus");

function parseLines(raw) {
  const ok = [], skipped = [];
  (raw || "").split(/\\r?\\n/).forEach(l => {
    const s = l.trim();
    if (!s) return;
    let a="", t=s;
    [" - "," — "," – ",": "].some(sep=>{
      if (s.includes(sep)) {
        [a,t]=s.split(sep,2); return true;
      }
    });
    if (!t) skipped.push(s);
    else ok.push({artist:a.trim(), title:t.trim(), raw:s});
  });
  return { ok, skipped };
}

document.getElementById("makeCrateBtn").onclick = () => {
  const { ok, skipped } = parseLines(rawTracks.value);
  const crate = {
    version: CJ_VERSION,
    created_at: new Date().toISOString(),
    track_count: ok.length,
    tracks: ok
  };
  out.textContent = JSON.stringify(crate, null, 2);
  status.textContent = \`Parsed \${ok.length} tracks\${skipped.length ? " · skipped "+skipped.length : ""}\`;
};

document.getElementById("downloadCrateBtn").onclick = () => {
  const blob = new Blob([out.textContent], {type:"application/json"});
  const a = document.createElement("a");
  a.href = URL.createObjectURL(blob);
  a.download = "crate_v1.json";
  a.click();
};

const SR = window.SpeechRecognition || window.webkitSpeechRecognition;
voiceStatus.textContent = SR
  ? "🎙 Voice supported — or use keyboard mic"
  : "🎙 Voice not supported → use keyboard mic to squeeze the Juice";
>>>>>>> 20abfb1 (Day 14 — Stone Core v1 locked)
