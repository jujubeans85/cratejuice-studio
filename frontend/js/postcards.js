import { QR_API_URL } from "./config.js";

const canvas = document.getElementById("postcardCanvas");
const ctx = canvas.getContext("2d");

const msg = document.getElementById("messageText");
const link = document.getElementById("qrData");
const sig = document.getElementById("signatureText");

const genBtn = document.getElementById("generateBtn");
const dlBtn = document.getElementById("downloadBtn");

function drawBase() {
  ctx.fillStyle = "#f5f0e6";
  ctx.fillRect(0,0,canvas.width,canvas.height);

  ctx.strokeStyle = "#c7b89b";
  ctx.lineWidth = 5;
  ctx.strokeRect(20,20,canvas.width-40,canvas.height-40);
}

async function generate() {
  drawBase();

  ctx.fillStyle = "#2b2112";
  ctx.font = "28px 'Times New Roman', serif";
  ctx.fillText(msg.value, 60, 150);

  ctx.font = "24px 'Brush Script MT', cursive";
  ctx.fillText(sig.value, 60, canvas.height - 60);

  if (!link.value.trim()) {
    dlBtn.disabled = false;
    return;
  }

  const resp = await fetch(QR_API_URL, {
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({ data: link.value })
  });

  const blob = await resp.blob();
  const img = new Image();
  img.onload = () => {
    ctx.drawImage(img, canvas.width - 260, 60, 200, 200);
    dlBtn.disabled = false;
  };
  img.src = URL.createObjectURL(blob);
}

function download() {
  const a = document.createElement("a");
  a.download = "cratejuice_postcard.png";
  a.href = canvas.toDataURL("image/png");
  a.click();
}

genBtn.onclick = () => { dlBtn.disabled = true; generate(); };
dlBtn.onclick = download;

drawBase();
