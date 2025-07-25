from flask import Flask, request, jsonify
import numpy as np
import cv2
from PIL import Image
import pickle
import io
from feature_extract import extract_all_features  # Your feature extraction function

# Load the trained model
with open("x_ray_neural.pkl", "rb") as f:
    model = pickle.load(f)

# Load the scaler
with open("scaler.pkl", "rb") as f:
    scaler = pickle.load(f)

# Initialize Flask app
app = Flask(__name__)

@app.route("/predict", methods=["POST"])
def predict():
    if 'image' not in request.files:
        return jsonify({"error": "No image uploaded"}), 400

    file = request.files['image']
    img_bytes = file.read()
    img = Image.open(io.BytesIO(img_bytes)).convert("L")  # Convert to grayscale
    img = img.resize((128, 128))  # Resize if needed

    # Convert PIL image to NumPy array
    img_np = np.array(img)

    # Extract features
    features = extract_all_features(img_np)

    # Reshape and scale
    features_scaled = scaler.transform([features])

    # Predict
    prediction = model.predict(features_scaled)[0]

    # Decode label (assuming 0: NORMAL, 1: PNEUMONIA)
    label = "NORMAL" if prediction == 0 else "PNEUMONIA"

    return jsonify({"prediction": int(prediction), 'result':label})

# Run the app
if __name__ == "__main__":
    app.run(debug=True)
