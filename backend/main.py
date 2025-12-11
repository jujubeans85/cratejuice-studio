# backend/main.py
# CrateJuice Studio – The Press (QR API v1.0)

import io
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse, JSONResponse
from pydantic import BaseModel
import qrcode
from qrcode.image.pil import PilImage

app = FastAPI(title="CrateJuice Press QR API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # tighten later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class QRRequest(BaseModel):
    data: str

@app.get("/health")
async def health():
    return {"status": "ok", "service": "cratejuice-press"}

@app.post("/api/qr/create")
async def create_qr(payload: QRRequest):
    if not payload.data.strip():
        return JSONResponse({"error": "Empty data"}, status_code=400)

    qr = qrcode.QRCode(version=1, box_size=8, border=2)
    qr.add_data(payload.data)
    qr.make(fit=True)
    img: PilImage = qr.make_image(fill_color="black", back_color="white")

    buf = io.BytesIO()
    img.save(buf, format="PNG")
    buf.seek(0)
    return StreamingResponse(buf, media_type="image/png")
