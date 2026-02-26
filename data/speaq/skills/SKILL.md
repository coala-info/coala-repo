---
name: speaq
description: SpeaQ performs Scene Graph Generation by enhancing Transformer-based detectors through groupwise query specialization for visual relationship detection. Use when user asks to train scene graph generation models, enable groupwise query specialization, or evaluate visual relationship detection performance.
homepage: https://github.com/mlvlab/SpeaQ
---


# speaq

## Overview
SpeaQ is a specialized implementation for Scene Graph Generation (SGG) that enhances Transformer-based detectors. It introduces groupwise query specialization to improve the quality of visual relationship detection. This skill facilitates the execution of the `train_iterative_model.py` workflow, covering environment setup, dataset mapping, and the specific hyperparameter flags required to enable SpeaQ's unique features over standard baseline models.

## Environment Setup
SpeaQ requires a specific legacy environment for compatibility:
- **Python**: 3.9
- **PyTorch**: 1.10.0 (CUDA 11.1)
- **Detectron2**: 0.5.1
- **Key Dependencies**: `setuptools==59.5.0`, `numpy==1.21.6`, `pillow==9.5.0`

## Training Workflows

### Baseline Model Training
To train the baseline model without SpeaQ enhancements, use the standard iterative configuration:
```bash
python train_iterative_model.py --resume --num-gpus <NUM_GPUS> \
  --config-file configs/speaq.yaml --dist-url <PORT_NUM> \
  OUTPUT_DIR <PATH_TO_CHECKPOINT_DIR> \
  DATASETS.VISUAL_GENOME.IMAGES <PATH_TO_VG_100K_IMAGES> \
  DATASETS.VISUAL_GENOME.MAPPING_DICTIONARY <PATH_TO_VG-SGG-dicts-with-attri.json> \
  DATASETS.VISUAL_GENOME.IMAGE_DATA <PATH_TO_image_data.json> \
  DATASETS.VISUAL_GENOME.VG_ATTRIBUTE_H5 <PATH_TO_VG-SGG-with-attri.h5> \
  MODEL.WEIGHTS <PATH_TO_vg_objectdetector_pretrained.pth>
```

### SpeaQ Model Training
To enable SpeaQ, append the following specific flags to the training command:
- `MODEL.DETR.ONE2MANY_SCHEME dynamic`
- `MODEL.DETR.MULTIPLY_QUERY 2`
- `MODEL.DETR.ONLY_PREDICATE_MULTIPLY True`
- `MODEL.DETR.ONE2MANY_K 4`
- `MODEL.DETR.ONE2MANY_DYNAMIC_SCHEME max`
- `MODEL.DETR.USE_GROUP_MASK True`
- `MODEL.DETR.MATCH_INDEPENDENT True`
- `MODEL.DETR.NUM_GROUPS 4`
- `MODEL.DETR.ONE2MANY_PREDICATE_SCORE True`
- `MODEL.DETR.ONE2MANY_PREDICATE_WEIGHT -0.5`

## Evaluation Procedure
For evaluation, you must switch the configuration file and enable the evaluation flag:
1. Change `--config-file` to `configs/speaq_test.yaml`.
2. Add the `--eval-only` flag.
3. Ensure `OUTPUT_DIR` points to the directory containing the trained `.pth` checkpoint.

## Expert Tips & Best Practices
- **Weight Initialization**: Always initialize the decoder weights using replicated DETR weights pre-trained on the Visual Genome (VG) dataset to ensure faster convergence.
- **Long-Tail Mitigation**: The framework uses a loss re-weighting scheme by default. To disable this for specific experiments, set `MODEL.DETR.OVERSAMPLE_PARAM 0.0` and `MODEL.DETR.UNDERSAMPLE_PARAM 0.0`.
- **Memory Management**: If encountering OOM (Out of Memory) errors during SpeaQ training, reduce `SOLVER.IMS_PER_BATCH` (default is 20).
- **Dataset Preparation**: Ensure you have the four critical Visual Genome files: the image directory, the attribute H5 file, the mapping dictionary JSON, and the image data JSON.

## Reference documentation
- [SpeaQ Main Repository](./references/github_com_mlvlab_SpeaQ.md)