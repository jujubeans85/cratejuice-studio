{
const likeSeed = document.getElementById("likeSeed");
const similarityStrict = document.getElementById("similarityStrict");

const wContinuous = document.getElementById("wContinuous");
const wRemixEthics = document.getElementById("wRemixEthics");
const wDynamics = document.getElementById("wDynamics");
const wOrchestration = document.getElementById("wOrchestration");
const wSpeech = document.getElementById("wSpeech");
const wTruth = document.getElementById("wTruth");

const downloadManifestBtn = document.getElementById("downloadManifestBtn");

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
