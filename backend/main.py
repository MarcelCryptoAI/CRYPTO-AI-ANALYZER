from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# ✅ CORS voor frontend-requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/ping")
def ping():
    return {"message": "pong"}

# ✅ Zorg dat de server start met logging
if __name__ == "__main__":
    import uvicorn
    print("🚀 Backend gestart op http://localhost:8000")
    uvicorn.run(app, host="0.0.0.0", port=8000)
