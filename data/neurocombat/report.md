# neurocombat Report

## Real Data Test

| Function | Result | Reason |
|---|---|---|
| `neuroCombat(..., categorical_cols=["subject"], mean_only=True, eb=True)` | PASS | simulated travelling-subject study (8 subjects on 2 to 5 of 6 sites, 200 features): site offset error 0.33 vs 0.46 with no correction |
| subject covariate left out | PASS (shows the pitfall) | offset error 0.56 with EB and 0.99 without, worse than no correction |
| offsets from `gamma.star * sqrt(var.pooled)` | PASS | reproduce `out["data"]` exactly (max difference 0) with `mean_only=True` |
| `neuroCombatFromTraining` | PASS | equals raw minus the stored offsets; raises `ValueError` for a site not in training |
| site with a single scan | PASS | fits with `mean_only=True` |

Tested with neuroCombat 0.2.12, numpy 1.26, pandas 2.2, Python 3.11.

## Metadata
- **Homepage**: https://github.com/Jfortin1/neuroCombat
- **PyPI**: https://pypi.org/project/neuroCombat/ (0.2.12, MIT licence)

## Notes
- No container image is published; install with pip.
- For transcriptomics batch correction see the `inmoose` and `bioconductor-sva` entries.
