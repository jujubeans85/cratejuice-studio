#!/usr/bin/env bash
 HEAD
set -euo pipefail

# CrateJuice Stone Core v1 — write core files
# Assumes repo structure:
#   /frontend
#     /press/index.html
#     /crate/index.html
#     /js/{config.js,postcard.js,crate.js}
#     /css/style.css (existing)
#   netlify.toml at repo root

mkdir -p frontend/js frontend/press frontend/crate

cat > netlify.toml <<'TOML'
=======
set -e

echo "🗿 Applying Day 14 Stone Core v1..."

# --- Ensure folders ---
mkdir -p frontend/js frontend/press frontend/crate frontend/css

# --- netlify.toml ---
cat <<'TOML' > netlify.toml
>>>>>>> 590ec85 (v1 cemented)
[build]
  publish = "frontend"
TOML

 HEAD
cat > frontend/_redirects <<'TXT'
/*    /index.html   200
TXT

cat > frontend/js/config.js <<'JS'
export const API_BASE = "https://cratejuice-press-backend.onrender.com";
export const CJ_VERSION = "v1.0.0-stonecore";
JS

cat > frontend/index.html <<'HTML'
=======
# --- _redirects ---
cat <<'REDIR' > frontend/_redirects
/*    /index.html   200
REDIR

# --- config.js ---
cat <<'CFG' > frontend/js/config.js
export const API_BASE = "https://cratejuice-press-backend.onrender.com";
export const CJ_VERSION = "v1.0.0-stonecore";
CFG

# --- index.html (Studio hub minimal + health check) ---
cat <<'HTML' > frontend/index.html
>>>>>>> 590ec85 (v1 cemented)
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>CrateJuice™ Studio</title>
  
 HEAD
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="/css/style.css" />
</head>

  <link rel="stylesheet" href="/css/style.css" />
</head>
>>>>>>> 590ec85 (v1 cemented)
<body class="cj-body">
  <div class="cj-frame">
    <header class="cj-header">
      <h1>CrateJuice™ Studio</h1>
    HEAD
      <p class="cj-tagline">Life is a playable map.</p>
    </header>

    <main class="cj-main">
      <section class="cj-panel">
        <h2>Machines</h2>

        <div class="cj-machines">
          <a class="cj-pill" href="/press/">Press · Sonic Postcards</a>
          <a class="cj-pill" href="/crate/">Crate Stacker · Tracklists → Crates</a>
        </div>

        <p class="cj-hint">More machines coming soon: Ripper, Mum Apps, Advocacy Engine…</p>
        <p class="cj-hint" id="studioStatus"></p>
      </section>
    </main>

    <footer class="cj-footer">
      <p>
        Welcome to Day Zero of the Cathedral.<br />
        Drop in, pick a machine, let the chaos get organised.
      </p>
      <p class="cj-signoff">CrateJuice™ 2025 · PLUR</p>
    </footer>
  </div>

  <script type="module">
    import { API_BASE, CJ_VERSION } from "/js/config.js";
    const el = document.getElementById("studioStatus");
    el.textContent = `Studio ${CJ_VERSION} · checking backend…`;
    fetch(`${API_BASE}/health`).then(r => r.json()).then(() => {
      el.textContent = `Studio ${CJ_VERSION} · backend OK`;
    }).catch(() => {
      el.textContent = `Studio ${CJ_VERSION} · backend unreachable (Render asleep or URL wrong)`;
    });
  </script>
=======
      <p class="cj-tagline">Idea → Artifact, no friction.</p>
    </header>

    <main class="cj-main">
      <a class="cj-btn" href="/press/">🎴 Press</a>
      <a class="cj-btn" href="/crate/">📦 Crate Room</a>
      <p class="cj-hint" id="studioStatus">Checking backend…</p>
    </main>

    <footer class="cj-footer">
      CrateJuice™ 2025 · PLUR
    </footer>
  </div>

<script type="module">
import { API_BASE, CJ_VERSION } from "/js/config.js";
const el = document.getElementById("studioStatus");
el.textContent = \`Studio \${CJ_VERSION} · checking backend…\`;
fetch(\`\${API_BASE}/health\`)
  .then(r => r.json())
  .then(() => el.textContent = \`Studio \${CJ_VERSION} · backend OK\`)
  .catch(() => el.textContent = \`Studio \${CJ_VERSION} · backend asleep / offline-first active\`);
</script>
>>>>>>> 590ec85 (v1 cemented)
</body>
</html>
HTML

HEAD
cat > frontend/press/index.html <<'HTML'
=======
# --- crate/index.html ---
cat <<'HTML' > frontend/crate/index.html
>>>>>>> 590ec85 (v1 cemented)
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
   HEAD
  <title>CrateJuice™ Press</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="/css/style.css" />
</head>

<body class="cj-body">
  <div class="cj-frame">
    <header class="cj-header">
      <h1>CrateJuice™ Press</h1>
      <p class="cj-tagline">Vintage Sonic Postcards for Special Humans</p>
    </header>

    <main class="cj-main">
      <section class="cj-form">
        <label class="cj-label">
          Message:
          <textarea id="messageText" rows="4" placeholder="Write something that survives time…"></textarea>
        </label>

        <label class="cj-label">
          QR Link:
          <input id="qrData" type="text" placeholder="https://your.link" />
        </label>

        <label class="cj-label">
          Signature:
          <input id="signatureText" type="text" placeholder="Love, Juice" />
        </label>

        <div class="cj-actions">
          <button id="generateBtn" class="cj-btn">Generate Postcard</button>
          <button id="downloadBtn" class="cj-btn cj-btn-secondary" disabled>Download</button>
        </div>

        <div id="pressStatus" class="cj-hint"></div>
      </section>

      <section class="cj-preview">
        <canvas id="postcardCanvas" width="1200" height="800"></canvas>
      </section>
    </main>

    <footer class="cj-footer">CrateJuice™ 2025 · PLUR</footer>
  </div>

  <script type="module" src="/js/postcard.js"></script>
=======
  <title>CrateJuice™ Crate Room</title>
  <link rel="stylesheet" href="/css/style.css" />
</head>
<body class="cj-body">
<div class="cj-frame">
<header class="cj-header">
  <h1>Crate Room</h1>
  <p class="cj-tagline">Offline-first · Taste over algorithm</p>
</header>

<main class="cj-main">
  <textarea id="rawTracks" rows="18" placeholder="Artist - Title (one per line)"></textarea>

  <input id="likeSeed" placeholder="Like… seed (optional)" />
  <input id="similarityStrict" type="range" min="0" max="100" value="60" />

  <button id="makeCrateBtn" class="cj-btn">Generate Crate</button>
  <button id="downloadCrateBtn" class="cj-btn cj-btn-secondary">Download Crate JSON</button>

  <div id="voiceStatus" class="cj-hint"></div>
  <div id="crateStatus" class="cj-hint"></div>

  <pre id="crateOut" class="cj-hint"></pre>
</main>

<footer class="cj-footer">CrateJuice™ 2025 · PLUR</footer>
</div>

<script type="module" src="/js/crate.js"></script>
>>>>>>> 590ec85 (v1 cemented)
</body>
</html>
HTML

HEAD
cat > frontend/crate/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>CrateJuice™ Crate Stacker</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="/css/style.css" />
</head>

<body class="cj-body">
  <div class="cj-frame">
    <header class="cj-header">
      <h1>Crate Stacker</h1>
      <p class="cj-tagline">Turn raw tracklists into living crates.</p>
    </header>

    <main class="cj-main">
      <section class="cj-form">
        <label class="cj-label">
          Crate name
          <input id="crateName" type="text" placeholder="High Energy – Vol 1" />
        </label>

        <label class="cj-label">
          Playlist URL (optional)
          <input id="playlistUrl" type="text" placeholder="https://open.spotify.com/playlist/..." />
        </label>

        <label class="cj-label">
          “Like…” seed (optional)
          <input id="likeSeed" type="text" placeholder="Best of Britney similarities (but darker / smarter)" />
        </label>

        <label class="cj-label">
          Similarity strictness
          <input id="similarityStrict" type="range" min="0" max="100" value="60" />
          <div class="cj-hint">0 = wide net · 100 = must match hard</div>
        </label>

        <div class="cj-hint"><b>Rule dials</b> (0–100)</div>

        <label class="cj-label">Continuous build
          <input id="wContinuous" type="range" min="0" max="100" value="85" />
        </label>

        <label class="cj-label">Remix ethics (nods, not cosplay)
          <input id="wRemixEthics" type="range" min="0" max="100" value="80" />
        </label>

        <label class="cj-label">Dynamics (no brickwall)
          <input id="wDynamics" type="range" min="0" max="100" value="75" />
        </label>

        <label class="cj-label">Digital orchestration
          <input id="wOrchestration" type="range" min="0" max="100" value="70" />
        </label>

        <label class="cj-label">Speech > singing
          <input id="wSpeech" type="range" min="0" max="100" value="65" />
        </label>

        <label class="cj-label">Truth over shine
          <input id="wTruth" type="range" min="0" max="100" value="90" />
        </label>

        <label class="cj-label">
          Wizard prompt (type or dictate)
          <textarea id="wizardText" rows="4" placeholder="Turn on mic to squeeze the Juice? Example: Name it 'Peace Hop v2'. Strictness 75. Continuous 85. Truth 95. Speech 70. Seed: Britney but darker."></textarea>
        </label>

        <div style="display:flex; gap:10px; flex-wrap:wrap;">
          <button id="applyWizardBtn" class="cj-btn cj-btn-secondary" type="button">Apply to dials</button>
          <button id="voiceBtn" class="cj-btn cj-btn-secondary" type="button">🎙️ Voice</button>
          <button id="keyboardMicBtn" class="cj-btn cj-btn-secondary" type="button" style="display:none;">
            Turn on mic to squeeze the Juice?
          </button>
        </div>

        <label class="cj-label">
          Tracklist (one per line: Artist - Title)
          <textarea id="rawTracks" rows="14" placeholder="Ugly Duckling - A Little Samba&#10;Jurassic 5 - Concrete Schoolyard"></textarea>
        </label>

        <div class="cj-actions">
          <button id="crateBtn" class="cj-btn" type="button">Generate Crate (offline)</button>
          <button id="downloadCrateBtn" class="cj-btn cj-btn-secondary" type="button" disabled>Download Crate JSON</button>
        </div>

        <div class="cj-actions">
          <button id="downloadManifestBtn" class="cj-btn cj-btn-secondary" type="button">Download Manifest JSON</button>
          <button id="makeCandidatesBtn" class="cj-btn" type="button">Make 10 candidates (seed)</button>
          <button id="debugPackBtn" class="cj-btn cj-btn-secondary" type="button">Download Debug Pack</button>
          <button id="downloadTasteBtn" class="cj-btn cj-btn-secondary" type="button">Download Taste Log</button>
        </div>

        <pre id="candidatesOut" class="cj-hint"></pre>
        <div id="crateStatus" class="cj-hint"></div>
        <div id="voiceStatus" class="cj-hint"></div>
      </section>

      <section class="cj-preview">
        <pre id="crateSummary" class="cj-hint">Paste a tracklist and hit "Generate Crate" to see it structured here.</pre>
      </section>
    </main>

    <footer class="cj-footer">CrateJuice™ 2025 · PLUR</footer>
  </div>

  <script type="module" src="/js/crate.js"></script>
</body>
</html>
HTML

cat > frontend/js/postcard.js <<'JS'
import { API_BASE } from "./config.js";

const messageText = document.getElementById("messageText");
const qrData = document.getElementById("qrData");
const signatureText = document.getElementById("signatureText");
const generateBtn = document.getElementById("generateBtn");
const downloadBtn = document.getElementById("downloadBtn");
const statusEl = document.getElementById("pressStatus");
const canvas = document.getElementById("postcardCanvas");
const ctx = canvas.getContext("2d");

let lastBlobUrl = null;

function setStatus(msg) {
  if (statusEl) statusEl.textContent = msg || "";
}

function wrapText(ctx, text, x, y, maxWidth, lineHeight) {
  const words = (text || "").split(/\s+/);
  let line = "";
  for (let n = 0; n < words.length; n++) {
    const testLine = line + words[n] + " ";
    const metrics = ctx.measureText(testLine);
    if (metrics.width > maxWidth && n > 0) {
      ctx.fillText(line, x, y);
      line = words[n] + " ";
      y += lineHeight;
    } else {
      line = testLine;
    }
  }
  ctx.fillText(line, x, y);
}

async function fetchQrPng(data) {
  const res = await fetch(`${API_BASE}/api/qr/create`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ data }),
  });
  if (!res.ok) throw new Error(`QR API error (${res.status})`);
  return await res.blob();
}

function drawBase() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = "#f3eee3";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  ctx.strokeStyle = "#c8bba6";
  ctx.lineWidth = 10;
  ctx.strokeRect(40, 40, canvas.width - 80, canvas.height - 80);

  ctx.fillStyle = "#2a2a2a";
  ctx.font = "40px serif";
  ctx.fillText("CrateJuice™ Press", 80, 120);
}

async function generate() {
  try {
    setStatus("Forging postcard…");
    downloadBtn.disabled = true;

    drawBase();

    const msg = (messageText?.value || "").trim();
    const sig = (signatureText?.value || "").trim();
    const link = (qrData?.value || "").trim();

    ctx.fillStyle = "#2a2a2a";
    ctx.font = "32px serif";
    wrapText(ctx, msg || "…", 90, 200, 700, 42);

    ctx.font = "28px serif";
    ctx.fillText(sig || "—", 90, 720);

    if (link) {
      const qrBlob = await fetchQrPng(link);
      const qrUrl = URL.createObjectURL(qrBlob);

      const img = new Image();
      await new Promise((resolve, reject) => {
        img.onload = resolve;
        img.onerror = reject;
        img.src = qrUrl;
      });

      const size = 220;
      ctx.drawImage(img, canvas.width - 90 - size, 140, size, size);
      URL.revokeObjectURL(qrUrl);
    }

    setStatus("Done. Download ready.");
    downloadBtn.disabled = false;
  } catch (e) {
    setStatus(`Press error: ${e.message}`);
  }
}

function download() {
  const name = "cratejuice-postcard.png";
  canvas.toBlob((blob) => {
    if (!blob) return;
    if (lastBlobUrl) URL.revokeObjectURL(lastBlobUrl);
    lastBlobUrl = URL.createObjectURL(blob);

    const a = document.createElement("a");
    a.href = lastBlobUrl;
    a.download = name;
    a.click();
  }, "image/png");
}

generateBtn?.addEventListener("click", generate);
downloadBtn?.addEventListener("click", download);

setStatus("");
drawBase();
JS

cat > frontend/js/crate.js <<'JS'
import { CJ_VERSION, API_BASE } from "./config.js";

const crateName = document.getElementById("crateName");
const playlistUrl = document.getElementById("playlistUrl");
const rawTracks = document.getElementById("rawTracks");

const likeSeed = document.getElementById("likeSeed");
const similarityStrict = document.getElementById("similarityStrict");

const wContinuous = document.getElementById("wContinuous");
const wRemixEthics = document.getElementById("wRemixEthics");
const wDynamics = document.getElementById("wDynamics");
const wOrchestration = document.getElementById("wOrchestration");
const wSpeech = document.getElementById("wSpeech");
const wTruth = document.getElementById("wTruth");

const wizardText = document.getElementById("wizardText");
const applyWizardBtn = document.getElementById("applyWizardBtn");
const voiceBtn = document.getElementById("voiceBtn");
const keyboardMicBtn = document.getElementById("keyboardMicBtn");

const crateBtn = document.getElementById("crateBtn");
const downloadCrateBtn = document.getElementById("downloadCrateBtn");
const downloadManifestBtn = document.getElementById("downloadManifestBtn");
const makeCandidatesBtn = document.getElementById("makeCandidatesBtn");
const debugPackBtn = document.getElementById("debugPackBtn");
const downloadTasteBtn = document.getElementById("downloadTasteBtn");

const candidatesOut = document.getElementById("candidatesOut");
const crateSummary = document.getElementById("crateSummary");
const statusEl = document.getElementById("crateStatus");
const voiceStatus = document.getElementById("voiceStatus");

let lastCrate = null;

function setStatus(msg) {
  if (statusEl) statusEl.textContent = msg || "";
}

function clamp(n, a=0, b=100){ return Math.max(a, Math.min(b, n)); }

function buildManifest() {
  return {
    crate_name: (crateName?.value || "Untitled Crate").trim(),
    playlist_url: (playlistUrl?.value || "").trim() || null,
    like_seed: (likeSeed?.value || "").trim() || null,
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
    version: CJ_VERSION,
  };
}

function parseLines(raw) {
  const lines = (raw || "").split(/\r?\n/);
  const ok = [];
  const skipped = [];
  for (const ln of lines) {
    const s = ln.trim();
    if (!s) continue;

    let artist = "", title = s;

    if (s.includes(" - ")) [artist, title] = s.split(" - ", 2);
    else if (s.includes(" — ")) [artist, title] = s.split(" — ", 2);
    else if (s.includes(": ")) [artist, title] = s.split(": ", 2);
    else if (s.includes(" – ")) [artist, title] = s.split(" – ", 2);

    artist = (artist || "").trim();
    title = (title || "").trim();

    if (!title) { skipped.push(s); continue; }
    ok.push({ artist, title, raw: s });
  }
  return { ok, skipped };
}

function downloadJson(filename, obj) {
  const blob = new Blob([JSON.stringify(obj, null, 2)], { type: "application/json" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}

function logEvent(type, payload) {
  const key = "cj_taste_log_v1";
  const entry = { t: new Date().toISOString(), type, payload };
  const arr = JSON.parse(localStorage.getItem(key) || "[]");
  arr.push(entry);
  localStorage.setItem(key, JSON.stringify(arr.slice(-500)));
}

function downloadTasteLog() {
  const key = "cj_taste_log_v1";
  const arr = JSON.parse(localStorage.getItem(key) || "[]");
  const blob = new Blob([arr.map(x => JSON.stringify(x)).join("\n")], { type: "text/plain" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `taste_log_v1.jsonl`;
  a.click();
  URL.revokeObjectURL(url);
}

function downloadDebugPack() {
  const pack = {
    version: CJ_VERSION,
    when: new Date().toISOString(),
    api_base: API_BASE,
    last_manifest: buildManifest(),
    last_crate: lastCrate,
    taste_log_tail: JSON.parse(localStorage.getItem("cj_taste_log_v1") || "[]").slice(-20),
  };
  downloadJson("cj_debug_pack_v1.json", pack);
}

function applyIntentToForm(text) {
  if (!text) return;
  const t = text.toLowerCase();

  const nameMatch = text.match(/(?:name it|call it)\s["“]?([^"”\n]+)["”]?/i);
  if (nameMatch && crateName) crateName.value = nameMatch[1].trim();

  const strictMatch = text.match(/(?:strictness|similarity)\s*(\d{1,3})/i);
  if (strictMatch && similarityStrict) similarityStrict.value = clamp(Number(strictMatch[1]));

  const bump = (el, amount) => { if (!el) return; el.value = clamp(Number(el.value || 0) + amount); };

  if (t.includes("continuous") || t.includes("no chorus") || t.includes("build")) bump(wContinuous, 10);
  if (t.includes("remix") || t.includes("edit") || t.includes("rework") || t.includes("dna nod")) bump(wRemixEthics, 10);
  if (t.includes("dynamics") || t.includes("not brickwalled") || t.includes("breathing")) bump(wDynamics, 10);
  if (t.includes("orchestration") || t.includes("layered") || t.includes("sounddesign")) bump(wOrchestration, 10);
  if (t.includes("speech") || t.includes("spoken") || t.includes("voice drop")) bump(wSpeech, 10);
  if (t.includes("truth") || t.includes("lofi") || t.includes("real") || t.includes("no shine")) bump(wTruth, 10);

  const setDial = (regex, el) => {
    const m = text.match(regex);
    if (m && el) el.value = clamp(Number(m[1]));
  };

  setDial(/continuous\s*(\d{1,3})/i, wContinuous);
  setDial(/remix(?:\s*ethics)?\s*(\d{1,3})/i, wRemixEthics);
  setDial(/dynamics\s*(\d{1,3})/i, wDynamics);
  setDial(/orchestration\s*(\d{1,3})/i, wOrchestration);
  setDial(/speech\s*(\d{1,3})/i, wSpeech);
  setDial(/truth\s*(\d{1,3})/i, wTruth);

  const seedMatch = text.match(/(?:seed|like)\s*[:\-]?\s*(.+)$/i);
  if (seedMatch && likeSeed) likeSeed.value = seedMatch[1].trim();
}

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
    s >= 80 ? "very close to" :
    s >= 55 ? "in the world of" :
              "loosely inspired by";

  const prompts = [
    `Find tracks ${strictWord} "${seed}" with ${tags.join(", ")}.`,
    `Search: "${seed}" + edit + continuous mix (avoid big drops).`,
    `Search: "${seed}" + rework + extended + no chorus.`,
    `Find a version of "${seed}" with subtle classic beat nods (funk ghost / snap).`,
    `Hunt a darker/smarter sibling of "${seed}" with spoken emotional fragments.`,
    `Find slow swagger cousins: real instrument samples + breathing dynamics.`,
    `Rabbit hole credits: producers/remixers adjacent to "${seed}".`,
    `Search: "${seed}" + radio rip / live session (keep it musical).`,
    `Underground twin: low play-count version that builds to the end.`,
    `Final filter: no pop structure + feels truthful. If not, bin it.`,
  ];

  return prompts.map((p, i) => `${i + 1}. ${p}`);
}

function generateCrateOffline() {
  const manifest = buildManifest();
  const { ok, skipped } = parseLines(rawTracks?.value || "");

  if (!ok.length) throw new Error("No tracks parsed. Use: Artist - Title (one per line).");

  const crate = {
    crate_name: manifest.crate_name,
    playlist_url: manifest.playlist_url,
    track_count: ok.length,
    tracks: ok,
    skipped_lines: skipped,
    manifest,
    created_at: new Date().toISOString().slice(0, 10),
    sig: "CrateJuice™ 2025 · PLUR",
    version: CJ_VERSION,
  };

  lastCrate = crate;
  crateSummary.textContent = JSON.stringify(crate, null, 2);
  downloadCrateBtn.disabled = false;

  setStatus(`Parsed ${ok.length} tracks${skipped.length ? ` · skipped ${skipped.length}` : ""} · offline ready`);
  logEvent("crate_generated_offline", { manifest, track_count: ok.length, skipped: skipped.length });
}

applyWizardBtn?.addEventListener("click", () => applyIntentToForm(wizardText?.value || ""));

makeCandidatesBtn?.addEventListener("click", () => {
  const manifest = buildManifest();
  const list = make10Candidates(manifest);
  candidatesOut.textContent = list.join("\n");
  logEvent("candidates_generated", { seed: manifest.like_seed, strictness: manifest.similarity_strictness });
});

downloadManifestBtn?.addEventListener("click", () => {
  const manifest = buildManifest();
  const safe = (manifest.crate_name || "crate").replace(/[^\w\-]+/g, "_");
  downloadJson(`${safe}.manifest.json`, manifest);
});

downloadCrateBtn?.addEventListener("click", () => {
  if (!lastCrate) return;
  const safe = (lastCrate.crate_name || "crate").replace(/[^\w\-]+/g, "_");
  downloadJson(`${safe}.crate.json`, lastCrate);
});

debugPackBtn?.addEventListener("click", downloadDebugPack);
downloadTasteBtn?.addEventListener("click", downloadTasteLog);

crateBtn?.addEventListener("click", () => {
  try {
    setStatus("Stacking crate (offline)…");
    generateCrateOffline();
  } catch (e) {
    setStatus(`Crate error: ${e.message}`);
  }
});

// Voice support: Web Speech API if available; else redirect to keyboard dictation
const SR = window.SpeechRecognition || window.webkitSpeechRecognition;
if (voiceStatus) {
  voiceStatus.textContent = SR
    ? "Voice: supported here (tap 🎙️)"
    : "Voice: not supported — tap the button and use the keyboard mic 🎙️";
}

function redirectToKeyboardMic() {
  if (wizardText) {
    wizardText.focus();
    wizardText.scrollIntoView({ behavior: "smooth", block: "center" });
  }
  if (voiceStatus) voiceStatus.textContent = "Turn on mic to squeeze the Juice? Use the keyboard 🎙️ while the box is focused.";
}

if (!SR) {
  // Hide the real voice button, show the redirect prompt button
  if (voiceBtn) voiceBtn.style.display = "none";
  if (keyboardMicBtn) keyboardMicBtn.style.display = "inline-block";
  keyboardMicBtn?.addEventListener("click", redirectToKeyboardMic);
} else {
  if (keyboardMicBtn) keyboardMicBtn.style.display = "none";
  voiceBtn?.addEventListener("click", () => {
    try {
      const rec = new SR();
      rec.lang = "en-AU";
      rec.interimResults = false;
      rec.maxAlternatives = 1;

      rec.onresult = (e) => {
        const transcript = e.results?.[0]?.[0]?.transcript || "";
        if (wizardText) wizardText.value = transcript;
        applyIntentToForm(transcript);
        logEvent("voice_applied", { transcript });
      };
      rec.onerror = () => redirectToKeyboardMic();
      rec.start();
    } catch {
      redirectToKeyboardMic();
    }
  });
}

// Small “backend check” (non-blocking)
fetch(`${API_BASE}/health`).catch(() => {});
setStatus(`Stone Core ${CJ_VERSION} · ready`);
JS

echo "✅ Stone Core v1 files written."
echo "Next:"
echo "  git status"
echo "  git add -A && git commit -m \"Stone Core v1 (routes+press+crate offline+voice prompt)\""
echo "  git push"
=======
# --- crate.js ---
cat <<'JS' > frontend/js/crate.js
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
JS

chmod +x apply_stonecore_v1.sh
echo "✅ Stone Core v1 applied. Commit when ready."
 590ec85 (v1 cemented)
