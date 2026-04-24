from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import random

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"status":"KittU Health Genie Backend Live"}

@app.get("/vitals")
def vitals():
    return {
        "heart_rate": random.randint(65,95),
        "oxygen": random.randint(95,100),
        "temp": round(random.uniform(36.4,37.2),1),
        "risk":"LOW"
    }
