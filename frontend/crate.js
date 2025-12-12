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
