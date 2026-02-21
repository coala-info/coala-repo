---
name: clips
description: CLIP (Contrastive Language-Image Pretraining) is a multimodal neural network that connects images and text.
homepage: https://github.com/openai/CLIP
---

# clips

## Overview
CLIP (Contrastive Language-Image Pretraining) is a multimodal neural network that connects images and text. Unlike traditional computer vision models trained on a fixed set of labeled categories, CLIP is trained on a wide variety of (image, text) pairs from the internet. This allows it to be "instructed" in natural language to perform various classification tasks without needing to be fine-tuned on specific datasets. It is particularly powerful for zero-shot prediction, where the model identifies objects or concepts it has never explicitly seen in a supervised training context.

## Installation and Setup
To use CLIP, ensure the following dependencies are installed:
```bash
pip install ftfy regex tqdm
pip install git+https://github.com/openai/CLIP.git
```
Note: PyTorch 1.7.1 or later and torchvision are required.

## Core API Usage
The `clip` module provides a streamlined interface for loading models and processing data.

### Loading Models
Identify available architectures and load a specific model with its required preprocessing transform:
```python
import clip
import torch

# List available models (e.g., 'ViT-B/32', 'RN50')
print(clip.available_models())

device = "cuda" if torch.cuda.is_available() else "cpu"
model, preprocess = clip.load("ViT-B/32", device=device)
```

### Preparing Inputs
Images must be transformed via the `preprocess` function, and text must be tokenized.
```python
from PIL import Image

# Image: Load and add batch dimension
image = preprocess(Image.open("image.jpg")).unsqueeze(0).to(device)

# Text: Tokenize a list of strings
text = clip.tokenize(["a photo of a cat", "a photo of a dog"]).to(device)
```

### Inference Patterns
There are two primary ways to run the model:

**1. Direct Logits (Similarity Scores)**
Use this for quick classification or ranking.
```python
with torch.no_grad():
    logits_per_image, logits_per_text = model(image, text)
    probs = logits_per_image.softmax(dim=-1).cpu().numpy()
```

**2. Feature Extraction (Embeddings)**
Use this for building search indices or custom classifiers.
```python
with torch.no_grad():
    image_features = model.encode_image(image)
    text_features = model.encode_text(text)
    
    # Normalize for cosine similarity
    image_features /= image_features.norm(dim=-1, keepdim=True)
    text_features /= text_features.norm(dim=-1, keepdim=True)
```

## Expert Tips and Best Practices
- **Prompt Engineering**: CLIP performs significantly better when labels are wrapped in descriptive prompts. Instead of using "dog", use "a photo of a dog" or "a centered photo of a dog".
- **Memory Management**: Always use `with torch.no_grad():` during inference to prevent unnecessary gradient calculation and memory bloat.
- **Batching**: When processing large datasets, batch your images and text. `model.encode_image()` and `model.encode_text()` handle tensors representing batches efficiently.
- **Normalization**: If calculating similarity manually (e.g., `image_features @ text_features.T`), ensure both feature sets are L2-normalized.
- **Input Constraints**: The default `context_length` for text is 77 tokens. Longer text inputs will be truncated by `clip.tokenize()`.

## Reference documentation
- [CLIP Main Repository and API](./references/github_com_openai_CLIP.md)