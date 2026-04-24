import random

def predict_health():
    return {
        "risk": random.randint(1,100),
        "status":"normal"
    }
