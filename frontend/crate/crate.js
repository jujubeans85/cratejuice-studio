{
const likeSeed = document.getElementById("likeSeed");
const similarityStrict = document.getElementById("similarityStrict");

const wContinuous = document.getElementById("wContinuous");
const wRemixEthics = document.getElementById("wRemixEthics");
const wDynamics = document.getElementById("wDynamics");
const wOrchestration = document.getElementById("wOrchestration");
const wSpeech = document.getElementById("wSpeech");
const wTruth = document.getElementById("wTruth");
const makeCandidatesBtn = document.getElementById("makeCandidatesBtn");
const candidatesOut = document.getElementById("candidatesOut");

const downloadManifestBtn = document.getElementById("downloadManifestBtn");

  function make10Candidates(manifest) {
  const seed = (manifest.like_seed || "your seed").trim();
  const s = manifest.similarity_strictness;

  // Simple “dial -> language” mapping (v1)
  const w = manifest.rule_weights;
  const tags = [];

  if (w.continuous_build >= 70) tags.push("continuous-build", "no-chorus-reset");
  if (w.remix_ethics >= 70) tags.push("classic-DNA-nods", "no-nostalgia-cosplay");
  if (w.dynamics >= 70) tags.push("dynamic-range", "not-brickwalled");
  if (w.digital_orchestration >= 70) tags.push("digital-orchestration", "layered-sounddesign");
  if (w.speech_over_singing >= 70) tags.push("speech-drops", "found-voice");
  if (w.truth_over_shine >= 70) tags.push("truth-over-shine", "lofi-real");

  const strictWord =
    s >= 80 ? "very close to" :
    s >= 55 ? "in the world of" :
              "loosely inspired by";

  // 10 hunt-queries (search engine / SoundCloud / YouTube / Discogs)
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
    `Final filter: Does it avoid pop structure AND feel truthful? If not, bin it.`
  ];

  return prompts.map((p, i) => `${i + 1}. ${p}`);
}
function buildManifest() {
  return {
    crate_name: nameInput.value || "Untitled Crate",
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
    notes: "CrateJuice Studio – Music 11 Manifest (v1)"
  };
}

function downloadManifest() {
  const manifest = buildManifest();
  const blob = new Blob([JSON.stringify(manifest, null, 2)], { type: "application/json" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${manifest.crate_name}-manifest.json`;
  a.click();
  URL.revokeObjectURL(url);
}
  
downloadManifestBtn?.addEventListener("click", downloadManifest);
  "crate_name": "Peace Hop v1",
  "vibe": "Golden era hip-hop / head nod / soul-dusted boom bap",
  "playlist_source": "Screenshot import (Spotify)",
  "tracks": [
    { "artist": "Ugly Duckling", "title": "A Little Samba" },
    { "artist": "Jurassic 5", "title": "Concrete Schoolyard" },
    { "artist": "Gang Starr", "title": "Full Clip" },
    { "artist": "Mos Def", "title": "Mathematics" },
    { "artist": "Pharoahe Monch", "title": "Simon Says" },
    { "artist": "Dilated Peoples", "title": "Worst Comes To Worst" },
    { "artist": "Jaylib", "title": "The Red", "extra": "Madlib, J Dilla" },
    { "artist": "dj honda", "title": "Travellin' Man (Remastered)", "extra": "Mos Def" },
    { "artist": "Gang Starr", "title": "Work" },
    { "artist": "Hi-Tek", "title": "The Sun God" },
    { "artist": "Bahamadia", "title": "unknowhowwedu" },
    { "artist": "Mos Def", "title": "Hip Hop" },
    { "artist": "DJ Jazzy Jeff", "title": "For Da Love of Da Game", "extra": "Pauly Yamz, Baby Blak" },
    { "artist": "Gang Starr", "title": "Above The Clouds", "extra": "Inspectah Deck" },
    { "artist": "J Dilla", "title": "So Far to Go", "extra": "Common, D'Angelo" },
    { "artist": "MF DOOM", "title": "Doomsday", "extra": "Pebbles The Invisible Girl" },
    { "artist": "Talib Kweli", "title": "Fortified Live", "extra": "Yasiin Bey, Mr Man" },
    { "artist": "Dr. Octagon", "title": "Blue Flowers" },
    { "artist": "De La Soul", "title": "Rock Co.Kane Flow", "extra": "MF DOOM" },
    { "artist": "Mos Def", "title": "Body Rock", "extra": "Q-Tip, Tash" },
    { "artist": "MF DOOM", "title": "Rapp Snitch Knishes", "extra": "Mr Fantastik" },
    { "artist": "Blackalicious", "title": "Deception" },
    { "artist": "Dilated Peoples", "title": "This Way" }
  ],
  "track_count": 23,
  "created_at": "2025-12-12",
  "sig": "CrateJuice™ 2025 · PLUR"
}
data.manifest = buildManifest();
lastCrate = data;
makeCandidatesBtn?.addEventListener("click", () => {
  const manifest = buildManifest();
  const list = make10Candidates(manifest);
  candidatesOut.textContent = list.join("\n");
});
