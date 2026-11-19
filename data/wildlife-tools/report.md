# wildlife-tools Report

## Real Data Test

| Function | Result | Reason |
|---|---|---|
| `DeepFeatures` + `hf-hub:BVRA/MegaDescriptor-L-384` | PASS | StripeSpotter zebra photos (820 labelled images, 45 animals), 1536 values per image; leave-one-out top-1 0.98 with either normalisation |
| `DeepFeatures` + MiewID-msv3 (`transformers.AutoModel`) | PASS | 2152 values per image, about 0.6 s per image on 4 threads |
| `AlikedExtractor` + `MatchLightGlue(features="aliked")` with `CollectCounts` on a top-10 cosine shortlist | PASS | 5,749 pairs at about 0.5 s per pair; same-animal pairs median 49 confident matches, different-animal pairs median 9 |
| `IsotonicCalibration` fusion + open-set grouping from the skill | PASS | 30 known animals, query photos of 44 animals (15 unseen); thresholds chosen on a simulation inside the reference set; ARI 0.66 fused vs 0.35 global only; single linkage 0.22 |

Tested with wildlife-tools at git 66640fd, torch 2.11 CPU, timm 1.0.28, Python 3.11.

## Metadata
- **Homepage**: https://github.com/WildlifeDatasets/wildlife-tools
- **Documentation**: https://wildlifedatasets.github.io/wildlife-tools/
- **PyPI**: https://pypi.org/project/wildlife-tools/ (the git version is newer)

## Notes
- No published container image; install with pip from git (see the skill).
- Batched LightGlue fails on images of different sizes unless the dense score map is dropped from
  the ALIKED features; the skill shows how.
- MegaDescriptor was trained on public re-identification data sets, which likely include
  StripeSpotter, so its global scores on this test may be optimistic.
