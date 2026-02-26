# curve-curator CWL Generation Report

## curve-curator_CurveCurator

### Tool Description
Complete analysis pipeline for dose-response curves including fitting, filtering, and visualization. FPB-2024

### Metadata
- **Docker Image**: quay.io/biocontainers/curve-curator:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/kusterlab/curve_curator
- **Package**: https://anaconda.org/channels/bioconda/packages/curve-curator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/curve-curator/overview
- **Total Downloads**: 47
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/kusterlab/curve_curator
- **Stars**: N/A
### Original Help Text
```text
usage: CurveCurator [-h] [-b] [-f] [-m] [-r [RANDOM]] <PATH>

CurveCurator (v0.6.0)

positional arguments:
  <PATH>                Relative path to the config.toml or batch.txt file to
                        run the pipeline.

options:
  -h, --help            show this help message and exit
  -b, --batch           Run a batch process with a file containing all the
                        parameter file paths.
  -f, --fdr             Estimate FDR based on target decoy approach.
                        Estimating the FDR will double the run time.
  -m, --mad             Perform the medium absolute deviation (MAD) analysis
                        to detect outliers
  -r, --random [RANDOM]
                        Run the pipeline with <N> random values for H0
                        simulation.

Complete analysis pipeline for dose-response curves including fitting,
filtering, and visualization. FPB-2024
```

