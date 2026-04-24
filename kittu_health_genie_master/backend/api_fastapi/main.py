from fastapi import FastAPI

app = FastAPI(title="KittU Health Genie API")

@app.get("/")
def root():
    return {"status":"alive"}

@app.get("/predict-risk")
def predict():
    return {
        "heart_risk": 22,
        "brain_risk": 8,
        "status":"stable"
    }
