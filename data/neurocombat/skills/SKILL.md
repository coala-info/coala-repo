---
name: neurocombat
description: neuroCombat is the Python ComBat for MRI harmonization, removing scanner or site effects (batch effects) from MRI-derived measures such as imaging-derived phenotypes (IDPs), regional volumes, cortical thickness, diffusion (DTI) metrics and functional connectivity, with empirical Bayes shrinkage. Use when user asks to harmonize multi-site or multi-scanner neuroimaging data, remove scanner effects, fit ComBat or a location-only (mean-only) ComBat, use travelling-subject (travelling-head) data, export per-scanner offsets and apply them frozen to new data, or correct a scanner that was not in the training data.
homepage: https://github.com/Jfortin1/neuroCombat
---

# neuroCombat

## Overview
ComBat models each feature as `y = alpha + X*beta + gamma_site + delta_site * error`. `X` holds
biological covariates that must be kept (subject, age, sex, diagnosis). `gamma_site` is the additive
site effect and `delta_site` the multiplicative one. Empirical Bayes (EB) shrinks each site's
estimates toward that site's mean across all features, which steadies them when a site has few scans.
neuroCombat 0.2.12 (MIT licence) is a single Python function on numpy and pandas. The package
declares no dependencies, so install them with it: `pip install neuroCombat pandas numpy`.
Without pandas, `import neuroCombat` fails. No container image is published.

## Fit
```python
import numpy as np, pandas as pd
from neuroCombat import neuroCombat

# dat: features x scans (note the orientation); covars: one row per scan
out = neuroCombat(dat=Y.T, covars=meta[["site", "subject"]], batch_col="site",
                  categorical_cols=["subject"],       # biology to keep; continuous_cols=["age"]
                  eb=True, mean_only=True)            # mean_only: additive correction only
adjusted = out["data"].T                              # scans x features
est = out["estimates"]                                # dict, see below
```
- `est["batches"]` is the site order. `est["gamma.star"]` (sites x features) holds the EB site
  effects in standardised units, and `est["var.pooled"]` (features x 1) the pooled variance.
- The additive offset of each site in raw units is
  `offset = est["gamma.star"] * np.sqrt(est["var.pooled"]).T`. With `mean_only=True`,
  `adjusted == raw - offset[site]` exactly, so the offsets fully describe the correction and can be
  exported as `y_corrected = y - offset_site`. Offsets are relative to the pooled mean of all scans.
  With `ref_batch="SITE"` they are relative to that site, and its data stay unchanged.
- `mean_only=False` also rescales each site's spread with `delta.star`. Use it only when the target
  correction allows a scale, and when each site has enough scans to estimate a variance.
- `eb=False` gives the raw least-squares site effects; `parametric=False` uses a nonparametric prior.

## Design rules
- **Travelling subjects:** when the same people are scanned on several scanners, put the subject
  in `categorical_cols`. Otherwise the site effect absorbs differences between the people each site
  happened to scan. In a simulation with subjects spread unevenly over sites, leaving the subject
  out gave offsets worse than no correction at all.
- **Repeats:** repeat scans of one subject on one scanner are not extra subjects. Average them per
  subject and scanner before the fit, or use them only to measure test-retest noise.
- **Few scans per site:** unshrunk offsets from a handful of scans are noisy and can score worse
  than no correction. Keep `eb=True`, and compare on held-out subjects: no correction,
  `eb=False` and `eb=True`.
- Keep features on their natural scale. ComBat standardises each feature internally, so very
  different units across features are fine. A feature that is constant within a site, or has
  missing values, breaks the fit; drop or impute it first.

## Apply frozen estimates
```python
from neuroCombat import neuroCombatFromTraining
new = neuroCombatFromTraining(dat=Y_new.T, batch=meta_new["site"].values, estimates=est)["data"].T
```
- New scans must come from sites in the training data; an unseen site raises `ValueError`.
- To export a model, store the per-site offsets computed above, with the feature order.
- **Unseen site:** there is no estimate for it. The usual fallback is the mean offset of the
  training sites that share its vendor (or scanner model or field strength). If no such group
  exists, apply no correction.

## Checks
- Score every candidate on held-out subjects with the same metric the study uses, next to no
  correction: residual site effect (for example the site R² of each feature), test-retest or
  cross-site agreement, and kept biology (subject ranking, between-subject variance).
- Choose settings with held-out subjects (leave one subject out), never with the data you report on.
- Check that the exported offsets reproduce `out["data"]` on the training scans.
