---
name: wildlife-tools
description: wildlife-tools (WildlifeDatasets) is a Python library for animal re-identification, which tells individual animals apart from photos of their coats, spots, stripes, scales or faces. It extracts global features with MegaDescriptor or MiewID, matches local keypoints (ALIKED, SuperPoint, DISK, SIFT) with LightGlue, and calibrates and fuses scores (WildFusion). Use when user asks to identify individual animals from images, match query photos to a labelled reference set of known individuals, find new or unseen individuals (open-set re-identification), cluster photos into individuals, or estimate population size or abundance from camera-trap or photo-ID images.
homepage: https://github.com/WildlifeDatasets/wildlife-tools
---

# wildlife-tools

## Overview
Animal re-identification asks which photos show the same individual. A typical job has a labelled
reference set (known animals) and query photos that may show known animals or new ones. The answer
is a cluster label per query photo; the number of clusters estimates how many animals there are.

The work has three parts, and the last one decides most of the score:
1. Pair scores: a global feature per image (cosine similarity), then local keypoint matching on a
   shortlist of likely pairs.
2. Calibration: turn each raw score into a probability that a pair shows the same animal, from
   labelled reference pairs, so different scores can be averaged.
3. Open-set grouping: assign a query to a known animal only when the evidence is strong, group the
   rest into new animals, and choose every threshold on a simulation built from the reference set.

A model can rank the right animal first for almost every photo and still give poor clusters,
because one cut-off must separate same-animal pairs from different-animal pairs across all photos.
Measure the grouping, not only the ranking.

## Environment
- Check first whether the packages are already installed, often in a project virtual environment
  (`ls /opt /app; python -c "import wildlife_tools, lightglue, timm"` with each Python you find).
  Reinstalling torch wastes time.
- Install: `pip install git+https://github.com/WildlifeDatasets/wildlife-tools.git` with `timm`,
  `kornia`, `lmdb`, `pycocotools`, `omegaconf`. wildlife-tools pulls `gluefactory` and `lightglue`
  from git without a pinned commit. If the resolver reports "conflicting URLs for package
  lightglue", install everything else first, then
  `pip install --no-deps <gluefactory git URL> <lightglue git URL> <wildlife-tools git URL>`.
- Weights download on first use: MegaDescriptor-L-384 about 1.9 GB, -S-224 about 0.3 GB,
  -T-224 about 0.2 GB (`hf-hub:BVRA/...`), MiewID-msv3 about 0.2 GB, ALIKED 3 MB, and the
  ALIKED LightGlue weights 45 MB (from GitHub). MegaDescriptor weights are CC BY-NC 4.0.
- CPU threads: set `torch.set_num_threads(n)` and `OMP_NUM_THREADS`, `MKL_NUM_THREADS` and
  `OPENBLAS_NUM_THREADS` together. Too many threads across parallel jobs slows every job.

## Data
`ImageDataset(metadata, root, transform, col_path="path", col_label="identity")` reads a pandas
table with one row per image. Extractors return a `FeatureDataset` in the same row order.
```python
import pandas as pd
from wildlife_tools.data import ImageDataset
meta = pd.read_csv("metadata.csv").astype(object)   # pandas 3 string columns break some indexing
meta["identity"] = meta["identity"].fillna("unknown")  # query rows have no label; any string works
```
An extractor with `cache_path=` writes features to an LMDB keyed by `metadata["image_id"]`.

## Global features
```python
import timm, torch, torchvision.transforms as T
from wildlife_tools.features import DeepFeatures

model = timm.create_model("hf-hub:BVRA/MegaDescriptor-L-384", num_classes=0, pretrained=True)
cfg = model.pretrained_cfg                       # mean/std the timm config gives
tf = T.Compose([T.Resize((384, 384)), T.ToTensor(), T.Normalize(cfg["mean"], cfg["std"])])
feats = DeepFeatures(model, batch_size=16, num_workers=2, device="cpu")(ImageDataset(meta, root, tf))
X = feats.features                               # (n_images, 1536) numpy array
```
- The MegaDescriptor model card normalises with mean and std 0.5; the timm config gives ImageNet
  values. In a test on zebra photos the two gave almost the same ranking (ImageNet values slightly
  better). Pick one and use it for every image.
- MiewID: `transformers.AutoModel.from_pretrained("conservationxlabs/miewid-msv3",
  trust_remote_code=True)` with `T.Resize((440, 440))` and ImageNet mean and std; 2152 values per
  image. It is several times faster than MegaDescriptor-L-384 on CPU.
- Which model works best depends on the species. Compare candidates on the reference set (see the
  simulation below) before you commit hours of compute. Combining two models (concatenating
  normalised features, or averaging calibrated scores) often helps.
- A supervised projection learned from the reference identities (whitening, or linear discriminant
  analysis on the features) can sharpen the scores for one species. Whitened cosine values have a
  different range, so re-tune thresholds after it.
- Crop to the animal when the photo has much background.

## Local keypoint matching
Local matching checks that the same pattern appears in both photos. It is slow, so run it only on a
shortlist: the top k neighbours of each image by global cosine (k of 10 to 50).
```python
import numpy as np
from wildlife_tools.data import FeatureDataset
from wildlife_tools.features import AlikedExtractor
from wildlife_tools.similarity.pairwise.collectors import CollectCounts
from wildlife_tools.similarity.pairwise.lightglue import MatchLightGlue

tf_l = T.Compose([T.Resize(512), T.ToTensor()])          # shorter side 512, keeps aspect ratio
loc = AlikedExtractor(max_num_keypoints=512, device="cpu")(ImageDataset(meta, root, tf_l))
# Keep only what LightGlue needs. The full entry also holds a dense score map the size of the
# image: it uses about 1.7 MB per image and makes batches of differently sized images fail
# ("stack expects each tensor to be equal size").
keys = ("keypoints", "keypoint_scores", "descriptors", "image_size")
loc = FeatureDataset([{k: f[k] for k in keys} for f in loc.features], loc.metadata)

Xn = X / np.linalg.norm(X, axis=1, keepdims=True)
cos = Xn @ Xn.T                                           # global cosine, all pairs
top = np.argsort(-np.where(np.eye(len(cos), dtype=bool), -np.inf, cos), axis=1)[:, :k]
shortlist = sorted({(min(i, j), max(i, j)) for i in range(len(cos)) for j in top[i]})
pairs = np.array(shortlist)                               # row indices into the two datasets
matcher = MatchLightGlue(features="aliked", device="cpu", batch_size=64, tqdm_silent=True,
                         collector=CollectCounts(thresholds=[0.5]))
counts = matcher(loc, loc, pairs=pairs).astype(np.float32)  # (n, n) grid, NaN for unmatched pairs
counts = np.fmax(counts, counts.T)                          # fill the other triangle
np.save("lightglue_counts.npy", counts)                     # save before any later step can fail
```
- `CollectCounts` with one threshold returns the grid itself; with several it returns a dict keyed
  by threshold. `CollectCountsRansac()` counts RANSAC inliers instead of confident matches.
- The `features=` name must match the extractor: `"aliked"`, `"superpoint"`, `"disk"` or `"sift"`.
- ALIKED, SuperPoint and DISK are not rotation-invariant. When the animal can appear at any angle
  in the frame, use `SiftExtractor` with `features="sift"`, or rotate images to a common
  orientation first.
- Match only comparable views. A left flank never matches a right flank; if the metadata gives
  the side or viewpoint, compare within it.
- Restrict keypoints to the animal when the background or other objects repeat across photos;
  repeated backgrounds create false matches.

## Calibration and fusion
```python
from wildlife_tools.similarity.calibration import IsotonicCalibration
same = labels[i_idx] == labels[j_idx]                 # labelled reference pairs from the shortlist
cal_cos, cal_lg = IsotonicCalibration(), IsotonicCalibration()
cal_cos.fit(cos[i_idx, j_idx], same)
cal_lg.fit(counts[i_idx, j_idx], same)
P = (cal_cos.predict(cos.ravel()).reshape(cos.shape)
     + cal_lg.predict(np.nan_to_num(counts).ravel()).reshape(cos.shape)) / 2
```
- Fit calibration on reference pairs chosen the same way as the pairs you will score (the global
  shortlist). Random pairs are almost all easy negatives and give the wrong curve.
- For pairs outside the shortlist, use the calibrated value of zero matches, not NaN or minus
  infinity: average linkage cannot use infinite distances.
- `SimilarityPipeline` and `WildFusion` wrap these steps, but they extract features again on every
  call, and at this version the constructor arguments are `WildFusion(calibrated_pipelines=...,
  priority_pipeline=...)` (the docs say `calibrated_matchers`). With large sets, extract once and
  call the matcher and calibration directly as above.

## Open-set grouping
1. For each query, score each known identity by its best (or mean of top two) calibrated pair score
   with that identity's reference photos. Assign the query to the best identity when the score
   passes `t_known`.
2. Group the remaining queries with agglomerative clustering on `1 - P`:
   `AgglomerativeClustering(n_clusters=None, metric="precomputed", linkage="average",
   distance_threshold=1 - t_new)`. Each group is a new animal.
3. Never merge two different known identities, and never let one weak link join two large groups.
   Single linkage and connected components chain different animals into one cluster; average
   linkage, or requiring two strong links before a merge, avoids that.
4. High-precision local matches can act as must-links (pairs forced into one cluster), when the
   reference pairs show that a match count above some level is almost never a different animal.

### Choose every threshold on a simulation
Build a mock task from the reference set alone:
- hold out a third of the reference identities entirely (they play new animals);
- hold out about a third of the photos of each remaining identity (they play queries of known
  animals); if photos have dates, hold out the latest ones, since queries usually come later;
- run the full pipeline and score it the way the task does (for example the Adjusted Rand Index
  and the error in the number of clusters);
- grid-search `t_known`, `t_new` and any match-count cut-off, and keep the best setting;
- repeat with two or three random splits and prefer settings that are stable across them.
The simulation scores run higher than the real ones (the reference set is cleaner and smaller), so
use it to choose settings, not to predict the final score.
Tune per species or per data set: score scales differ between species. When a species has no
labels, choose cut-offs from a clear gap in the score distribution and check sample pairs by eye.
Do not select the shortlist or the pairs with the held-out labels; that leaks the answer into the
simulation and makes its scores look better than the real ones.

### Metadata
Use what the metadata gives: side or viewpoint, date and time, place. Photos taken seconds apart at
one place usually show one animal; treat such bursts as candidate groups, and check them with
keypoint matches before merging.

## CPU costs (4 threads)
- MegaDescriptor-L-384: about 1.5 s per image; MiewID: about 0.6 s per image.
- ALIKED with 512 keypoints at 512 px: about 0.5 s per image.
- LightGlue on ALIKED with 512 keypoints: about 0.5 s per pair, so about 7,000 pairs per hour.
- Global cosine for all pairs is instant; local matching on all pairs is not. Count the pairs
  (images x k) and the hours before you start, and fit k and the keypoint number to the time
  you have. Fewer keypoints (for example 256) cut the matching time.
- Save features and match counts to disk after each stage, and run long stages in the background
  with a log, so a crash or time-out does not repeat hours of work.

## Checks
- Report, per species, the simulation score of the setting you use, and the number of predicted
  clusters next to the number of known animals in the reference set.
- Look at a few assigned and a few new clusters: open two photos of one cluster side by side.
- Check that every query photo has exactly one label and that no label is empty.
