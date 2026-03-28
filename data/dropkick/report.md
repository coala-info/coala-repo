# dropkick CWL Generation Report

## dropkick_run

### Tool Description
Run dropkick to identify ambient RNA in single-cell data.

### Metadata
- **Docker Image**: quay.io/biocontainers/dropkick:1.2.8--py310h7eb0018_0
- **Homepage**: https://github.com/KenLauLab/dropkick
- **Package**: https://anaconda.org/channels/bioconda/packages/dropkick/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dropkick/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KenLauLab/dropkick
- **Stars**: N/A
### Original Help Text
```text
usage: dropkick run [-h] [-o [OUTPUT_DIR]] [--min-genes MIN_GENES]
                    [--n-ambient N_AMBIENT] [-m METRICS [METRICS ...]]
                    [--thresh-methods THRESH_METHODS [THRESH_METHODS ...]]
                    [--directions DIRECTIONS [DIRECTIONS ...]]
                    [--n-hvgs N_HVGS] [-a [ALPHAS ...]] [-i N_ITER]
                    [-j N_JOBS] [--seed SEED] [--csv] [-q]
                    counts

positional arguments:
  counts                Input (cell x gene) counts matrix as .h5ad or tab
                        delimited text file

options:
  -h, --help            show this help message and exit
  -o [OUTPUT_DIR], --output-dir [OUTPUT_DIR]
                        Output directory. Output will be placed in [output-
                        dir]/[name]_dropkick.h5ad. Default './'.
  --min-genes MIN_GENES
                        Minimum number of genes detected to keep cell. Default
                        50.
  --n-ambient N_AMBIENT
                        Number of top genes by dropout rate to use for ambient
                        profile. Default 10.
  -m METRICS [METRICS ...], --metrics METRICS [METRICS ...]
                        Heuristics for thresholding to build training set for
                        model.
  --thresh-methods THRESH_METHODS [THRESH_METHODS ...]
                        Method used for automatic thresholding on each
                        heuristic in '--metrics'.
  --directions DIRECTIONS [DIRECTIONS ...]
                        Direction of thresholding for each heuristic in '--
                        metrics'.
  --n-hvgs N_HVGS       Number of highly variable genes for training model.
                        Default 2000.
  -a [ALPHAS ...], --alphas [ALPHAS ...]
                        Ratio(s) between l1 and l2 regularization for
                        regression model. Default 0.1.
  -i N_ITER, --n-iter N_ITER
                        Maximum number of iterations for optimization. Default
                        2000.
  -j N_JOBS, --n-jobs N_JOBS
                        Maximum number of threads for cross validation.
                        Default 2.
  --seed SEED           Random state for cross validation.
  --csv                 Save dropkick scores and labels for each barcode to a
                        flat .csv file.
  -q, --quietly         Run without printing processing updates to console.
```


## dropkick_qc

### Tool Description
Quality control for single-cell RNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/dropkick:1.2.8--py310h7eb0018_0
- **Homepage**: https://github.com/KenLauLab/dropkick
- **Package**: https://anaconda.org/channels/bioconda/packages/dropkick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dropkick qc [-h] [-o [OUTPUT_DIR]] [--min-genes MIN_GENES]
                   [--n-ambient N_AMBIENT] [-q]
                   counts

positional arguments:
  counts                Input (cell x gene) counts matrix as .h5ad or tab
                        delimited text file

options:
  -h, --help            show this help message and exit
  -o [OUTPUT_DIR], --output-dir [OUTPUT_DIR]
                        Output directory. Output will be placed in [output-
                        dir]/[name]_dropkick.h5ad. Default './'.
  --min-genes MIN_GENES
                        Minimum number of genes detected to keep cell. Default
                        50.
  --n-ambient N_AMBIENT
                        Number of top genes by dropout rate to use for ambient
                        profile. Default 10.
  -q, --quietly         Run without printing processing updates to console.
```


## Metadata
- **Skill**: generated
