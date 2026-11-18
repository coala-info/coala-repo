# scimap Report

## Real Data Test

| Function | Result | Reason |
|---|---|---|
| `sm.pp.rescale` (GMM gates, `log=False`) | PASS | imaging mass cytometry cell table, about 660,000 cells by 35 markers over 158 regions; gates in `uns["gates"]`, rescaled values 0 to 1 with the gate at 0.5 |
| `sm.tl.phenotype_cells` | PASS | the three-level hierarchy in the skill (immune or stroma, then lineage, then T-cell subsets); labels including `Unknown`, parent labels and `likely-` labels |
| cluster tables | PASS | share of cells above each gate per cluster, and phenotype share per cluster, for 75 clusters |

The skill's code blocks ran unchanged in `labsyspharm/scimap:2.2.11`, with no network, in about 2 minutes.

## Metadata
- **Docker Image**: labsyspharm/scimap:2.2.11 (holds scimap 1.3.2 on Python 3.8; the `latest` tag holds the same package)
- **Homepage**: https://github.com/labsyspharm/scimap
- **Documentation**: https://scimap.xyz
- **PyPI**: https://pypi.org/project/scimap/ (2.4.1 needs Python 3.12 or later and has no published image)

## Notes
- Scimap is a Python library with no command line, so this entry has no CWL tool.
- The image tag does not give the package version. The skill documents the 1.3.2 functions found in the image.
- GMM gates on markers with many zeros or a broad background can sit low. The skill asks for a check of every lineage gate, and gives lineage rules for labelling clusters.
