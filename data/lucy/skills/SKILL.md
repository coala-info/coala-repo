---
name: lucy
description: Lucy is a video-to-video editing framework that performs precise, text-driven modifications while maintaining original motion and structure. Use when user asks to change clothing, add objects, replace subjects, or transform the overall style of a video.
homepage: https://github.com/DecartAI/Lucy-Edit-ComfyUI
---


# lucy

## Overview
Lucy Edit is a specialized video-to-video editing framework designed for precise, text-driven modifications. It transforms Claude into an expert at guiding video edits that maintain the original footage's motion and structure while altering specific elements like outfits, subjects, or environments. It is particularly effective for tasks requiring high identity preservation and temporal consistency.

## Prompting Best Practices
The model responds best to "enriched" prompts containing 20–30 descriptive words. Use specific trigger words to define the intent of the edit.

### Core Trigger Words
- **Change**: Best for clothing, accessories, or color modifications.
- **Add**: Best for wearable items, handheld props, or animals (often attaches to the subject).
- **Replace**: Best for subject swaps (e.g., person to creature) or object substitution of similar scale.
- **Transform to**: Best for global scene changes or style shifts (e.g., "Transform to 2D anime").

### Prompt Construction Patterns
- **Clothing Changes**: Use the format "Change the [garment] to a [new garment]..." and include details on materials, patterns, and fit.
- **Character Replacement**: Use "Replace the [person/man/woman] with a [detailed description]...". Describe age, attire, pose, and textures (e.g., "fuzzy fur"). Avoid using pronouns like "him" or "her."
- **Object Addition**: Specify placement clearly (e.g., "Add a golden crown on the person's head").
- **Color Modifications**: Be precise about the finish (e.g., "Change the jacket color to deep red leather with a glossy finish").

## Technical Setup & Usage
Lucy Edit is implemented as a ComfyUI custom node.

### Installation
1. Clone the repository into the ComfyUI `custom_nodes` folder.
2. Install requirements: `pip install -r requirements.txt`.
3. Place model weights (`.safetensors`) in `models/diffusion_models/`.

### Model Weights
- **FP16**: `lucy-edit-1.1-dev-cui-fp16.safetensors` (Recommended for most setups).
- **FP32**: `lucy-edit-1.1-dev-cui.safetensors`.

### Operational Tips
- **Temporal Consistency**: For the best results, target 81-frame generations.
- **Prompt Enrichment**: If a user provides a short request (e.g., "make him a robot"), expand it into a 20-30 word description of materials, lighting, and specific robotic features to improve model adherence.
- **Workflow Loading**: Use `basic-lucy-edit-dev.json` for local inference or `basic-api-lucy-edit.json` for API-based processing.

## Reference documentation
- [Lucy Edit Main](./references/github_com_DecartAI_Lucy-Edit-ComfyUI.md)
- [Examples and Workflows](./references/github_com_DecartAI_Lucy-Edit-ComfyUI_tree_main_examples.md)