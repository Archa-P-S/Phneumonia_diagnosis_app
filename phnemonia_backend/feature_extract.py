from skimage.feature import hog, local_binary_pattern
from skimage.filters import gabor
from skimage.measure import moments, moments_hu
from mahotas.features import zernike_moments
import pywt
import cv2
import numpy as np
#from tqdm import tqdm
import mahotas
def extract_hog(img):
    return hog(img, pixels_per_cell=(16, 16), cells_per_block=(2, 2), feature_vector=True)

def extract_lbp(img):
    lbp = local_binary_pattern(img, P=8, R=1, method="uniform")
    (hist, _) = np.histogram(lbp.ravel(), bins=np.arange(0, 10), range=(0, 9))
    hist = hist.astype("float")
    hist /= (hist.sum() + 1e-6)
    return hist

def extract_gabor(img):
    filt_real, filt_imag = gabor(img, frequency=0.6)
    return np.array([filt_real.mean(), filt_real.var(), filt_imag.mean(), filt_imag.var()])

def extract_wavelet(img):
    coeffs = pywt.wavedec2(img, 'db1', level=2)
    features = []

    # First element is approximation coefficients
    features.append(coeffs[0].ravel()[:10])  # cA

    # Next elements are (cH, cV, cD) tuples
    for detail in coeffs[1:]:
        for arr in detail:
            features.append(arr.ravel()[:10])

    return np.hstack(features)

def extract_hu_moments(img):
    moments_val = cv2.moments(img)
    return cv2.HuMoments(moments_val).flatten()

def extract_zernike(img):
    img_float = img.astype(np.uint8)
    return zernike_moments(img_float, radius=64, degree=8)

def extract_glcm_mahotas(img):
    # Ensure uint8 grayscale image
    img_uint8 = img.astype(np.uint8)
    # Mahotas haralick returns 13 features × 4 directions
    haralick_feats = mahotas.features.haralick(img_uint8, return_mean=True)
    return haralick_feats

def extract_all_features(img):
    img_resized = cv2.resize(img, (128, 128))  # Resize for consistency
    features = np.hstack([
        extract_glcm_mahotas(img_resized),
        extract_lbp(img_resized),
        extract_gabor(img_resized),
        extract_wavelet(img_resized),
        extract_hu_moments(img_resized),
        extract_hog(img_resized),
        extract_zernike(img_resized)

    ])
    return features.astype(np.float32)