---
name: paperbanana
description: PaperBanana is a multi-agent framework that automates the creation of academic illustrations and statistical plots from scientific text or data. Use when user asks to generate methodology diagrams from research text, create statistical plots from raw data, or refine existing images for academic publication.
homepage: https://github.com/dwzhu-pku/PaperBanana
metadata:
  docker_image: "hubentu/paperbanana"
---


# paperbanana

## Overview

PaperBanana is a multi-agent framework for academic illustrations. The CWL wrapper runs **`python /app/generate.py`** (PaperVizAgent single-sample processing) inside `hubentu/paperbanana`. It accepts direct text or a file, runs the agent pipeline, and writes a JSON trace plus a rendered image.

## Task types (`--task_name`)

| Value | Use for |
|-------|---------|
| `diagram` | Methodology / architecture figures from prose (default) |
| `plot` | Statistical plots from raw data (text or JSON) |

## Core inputs

Provide source content **either** inline or from a file (not both required):

| Parameter | CWL id | Type | Description |
|-----------|--------|------|-------------|
| `--task_name` | `task_name` | string | `diagram` or `plot` |
| `--raw_text` | `raw_text` | string | Methodology text (diagram) or plot data as text/JSON (plot) |
| `--raw_file` | `raw_file` | File | File containing the same content as `raw_text` |
| `--caption_intent` | `caption_intent` | string | Figure caption (diagram) or visual intent (plot) |

## Pipeline and retrieval

| Parameter | CWL id | Type | Description |
|-----------|--------|------|-------------|
| `--model_config` | `model_config` | File | Path to `model_config.yaml` (default in image: `/app/configs/model_config.yaml`) |
| `--exp_mode` | `exp_mode` | string | Experiment pipeline mode (default: `demo_full`) |
| `--retrieval_setting` | `retrieval_setting` | string | Planner retrieval: `auto`, `manual`, `random`, or `none` (default: `auto`) |
| `--ref_dir` | `ref_dir` | Directory | Directory with `ref.json` and reference images for Retriever/Planner (default: `data/PaperBananaBench/{task_name}`) |
| `--planner-metaphor` | `planner_metaphor` | boolean | Diagram only: enable Planner visual-metaphor discovery before detailed description |
| `--max_critic_rounds` | `max_critic_rounds` | int | Maximum critic refinement rounds (default: `3`) |

## Model and image settings

| Parameter | CWL id | Type | Description |
|-----------|--------|------|-------------|
| `--main_model_name` | `main_model_name` | string | Main VLM name (default from `model_config` → `defaults.main_model_name`) |
| `--image_gen_model_name` | `image_gen_model_name` | string | Image generation model (default from `model_config` → `defaults.image_gen_model_name`) |
| `--aspect_ratio` | `aspect_ratio` | string | Output aspect ratio, e.g. `1:1`, `16:9`, `21:9` (default: `1:1`) |
| `--image_size` | `image_size` | string | Resolution when supported: `1k`, `2k`, or `4k` (default: `1k`) |

## Outputs (required in CWL jobs)

| Parameter | CWL id | Type | Description |
|-----------|--------|------|-------------|
| `--output` | `output` | string | Output JSON path |
| `--image_output` | `image_output` | string | Output image path |

CWL captures both as File outputs: `output_output` (JSON) and `output_image_output` (image).

## CLI examples

### Diagram from inline text

```bash
python /app/generate.py \
  --task_name diagram \
  --raw_text "$(cat method.md)" \
  --caption_intent "System architecture overview" \
  --output results/diagram.json \
  --image_output results/diagram.jpg
```

### Diagram from file with retrieval

```bash
python /app/generate.py \
  --task_name diagram \
  --raw_file method.md \
  --caption_intent "Pipeline overview" \
  --retrieval_setting auto \
  --ref_dir data/PaperBananaBench/diagram \
  --max_critic_rounds 3 \
  --aspect_ratio 16:9 \
  --image_size 2k \
  --output results/run.json \
  --image_output results/run.jpg
```

### Plot from JSON data

```bash
python /app/generate.py \
  --task_name plot \
  --raw_file plot_data.json \
  --caption_intent "Bar chart comparing model accuracy" \
  --output results/plot.json \
  --image_output results/plot.jpg
```

## Workflows

### 1. Diagram generation
Set `task_name: diagram`, supply `raw_text` or `raw_file` with methodology prose, and `caption_intent` with the target figure caption. Use `exp_mode` and `retrieval_setting` to control the full PaperBanana pipeline vs simpler modes. Enable `planner_metaphor` for visual-metaphor planning before detailed layout.

### 2. Statistical plotting
Set `task_name: plot`, pass plot data via `raw_text` or `raw_file` (text/JSON), and describe the desired chart in `caption_intent`.

### 3. Higher quality / iteration
Increase `max_critic_rounds`, tune `main_model_name` and `image_gen_model_name` via `model_config` or CLI overrides, and set `aspect_ratio` / `image_size` for publication dimensions.

## Expert tips

- **Context length**: ~3,000 words of source text helps the Planner for complex diagrams.
- **Retrieval**: Point `ref_dir` at a folder with `ref.json` and reference images (e.g. under `data/PaperBananaBench/diagram`) when using `retrieval_setting: auto` or `manual`.
- **Connectivity**: If arrows or node links are wrong, run again with higher `max_critic_rounds` or adjust `caption_intent` with specific layout fixes.
- **Network**: The CWL tool requires `NetworkAccess` for model API calls.

## Subcommands

| Command | Description |
|---------|-------------|
| `python /app/generate.py` | PaperVizAgent single-sample processing (direct text or file input) |

## Reference documentation

- [PaperBanana README](./references/github_com_dwzhu-pku_PaperBanana_blob_main_README.md)
- [PaperBanana Project Page](./references/dwzhu-pku_github_io_PaperBanana.md)
