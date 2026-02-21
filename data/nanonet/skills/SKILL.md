---
name: nanonet
description: The nanonet skill provides a framework for multi-object tracking using the DeepSORT algorithm.
homepage: https://github.com/abhyantrika/nanonets_object_tracking
---

# nanonet

## Overview
The nanonet skill provides a framework for multi-object tracking using the DeepSORT algorithm. It bridges the gap between object detection (identifying what is in a frame) and object tracking (maintaining the identity of those objects across frames). This implementation is particularly valuable for scenarios requiring custom feature extraction, such as vehicle tracking in urban environments, where standard person-focused models may underperform. It allows for the integration of pre-calculated detections and the training of Siamese networks to improve re-identification accuracy.

## Implementation Patterns

### Basic Tracking Workflow
To implement tracking in a Python script, use the `deepsort_rbc` bridge class. The tracker requires a feature extractor model and a set of detections for each frame.

```python
# 1. Initialize the tracker with a feature extractor (e.g., vehicle-trained model)
deepsort = deepsort_rbc(wt_path='ckpts/model640.pt')

# 2. Process frames (detections must be pre-obtained from YOLO/SSD/etc.)
# detections: list of [x1, y1, x2, y2]
# out_scores: list of confidence scores
tracker, detections_class = deepsort.run_deep_sort(frame, out_scores, detections)

# 3. Extract tracking results
for track in tracker.tracks:
    if not track.is_confirmed() or track.time_since_update > 1:
        continue
    bbox = track.to_tlbr() # Get [top, left, bottom, right]
    track_id = track.track_id # Unique ID for the object
    features = track.features # Re-ID feature vector
```

### Training Custom Feature Extractors
If tracking objects other than people (e.g., cars, animals), train a custom Siamese network to improve the tracker's ability to re-identify objects after occlusion.

1. **Prepare Data**: Organize images into `crops/` and `crops_test/` folders, where each sub-folder contains different views of the same unique object.
2. **Execute Training**: Run the training script to generate new weights in the `ckpts/` directory.
   ```bash
   python siamese_train.py
   ```
3. **Validate Model**: Check the accuracy of the feature extractor.
   ```bash
   python siamese_test.py
   ```

## Expert Tips and Best Practices

- **Detection Dependency**: This module does not perform detection internally. Ensure detections are formatted as `[x1, y1, x2, y2]` before passing them to the `run_deep_sort` method.
- **Coordinate Systems**: The tracker uses `to_tlbr()` (Top, Left, Bottom, Right) for output. Ensure your visualization logic matches this coordinate format.
- **Performance Tuning**: If tracking is lost frequently, consider retraining the Siamese network on a dataset more representative of your target environment (e.g., NVIDIA AI City Challenge dataset for vehicles).
- **Environment Setup**: Always ensure `requirements.txt` is installed, as the module relies on specific versions of TensorFlow and OpenCV for the Kalman filter and feature extraction logic.

## Reference documentation
- [Main Repository README](./references/github_com_abhyantrika_nanonets_object_tracking.md)