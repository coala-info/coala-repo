# amiga CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| amiga_compare | PASS |  |
| amiga_fit | PASS |  |
| amiga_get_confidence | PASS |  |
| amiga_get_time | Failed | tool bug: amiga 3.0.4 get_time imports get_time_main from amiga.libs.thresholds, which defines only main, so the command always stops with an ImportError. |
| amiga_heatmap | PASS |  |
| amiga_normalize | PASS |  |
| amiga_summarize | PASS |  |
| amiga_test | PASS |  |

## amiga_summarize

### Tool Description
Perform a basic summary and plot curves

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT [-o OUTPUT] [--dont-plot] [--merge-summary]
             [--verbose] [-f FLAG] [-s SUBSET] [-y HYPOTHESIS] [-t INTERVAL]
             [--save-cleaned-data] [--save-mapping-tables] [--subtract-blanks]
             [--subtract-control]

Perform a basic summary and plot curves

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  -o OUTPUT, --output OUTPUT
  --dont-plot
  --merge-summary
  --verbose
  -f FLAG, --flag FLAG
  -s SUBSET, --subset SUBSET
  -y HYPOTHESIS, --hypothesis HYPOTHESIS
  -t INTERVAL, --interval INTERVAL
  --save-cleaned-data
  --save-mapping-tables
  --subtract-blanks
  --subtract-control
```


## amiga_fit

### Tool Description
Fit growth curves

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT [-o OUTPUT] [-f FLAG] [-s SUBSET] [-t INTERVAL]
             [-tss TIME_STEP_SIZE] [-sfn SKIP_FIRST_N]
             [--do-not-log-transform] [--subtract-blanks] [--subtract-control]
             [--keep-missing-time-points] [--verbose] [--plot]
             [--plot-derivative] [--pool-by POOL_BY] [--save-cleaned-data]
             [--save-mapping-tables] [--save-gp-data] [--merge-summary]
             [--fix-noise] [--sample-posterior]

Fit growth curves

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  -o OUTPUT, --output OUTPUT
  -f FLAG, --flag FLAG
  -s SUBSET, --subset SUBSET
  -t INTERVAL, --interval INTERVAL
  -tss TIME_STEP_SIZE, --time-step-size TIME_STEP_SIZE
  -sfn SKIP_FIRST_N, --skip-first-n SKIP_FIRST_N
  --do-not-log-transform
  --subtract-blanks
  --subtract-control
  --keep-missing-time-points
  --verbose
  --plot
  --plot-derivative
  --pool-by POOL_BY
  --save-cleaned-data
  --save-mapping-tables
  --save-gp-data
  --merge-summary
  --fix-noise
  --sample-posterior
```


## amiga_normalize

### Tool Description
Normalize growth parameters of fitted curves

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT [--over-write] [--verbose] [--group-by GROUP_BY]
             [--normalize-by NORMALIZE_BY]
             [--normalize-method {division,subtraction}]

Compare two growth curves

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  --over-write          Over-write file otherwise a new copy is made with
                        "_normalize" suffix
  --verbose
  --group-by GROUP_BY
  --normalize-by NORMALIZE_BY
  --normalize-method {division,subtraction}
```


## amiga_compare

### Tool Description
Compare two growth curves

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT -o OUTPUT -s SUBSET [--confidence CONFIDENCE]
             [--verbose]

Compare two growth curves

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  -o OUTPUT, --output OUTPUT
                        ouptut filename including path
  -s SUBSET, --subset SUBSET
  --confidence CONFIDENCE
                        Must be between 80 and 100. Default is 95.
  --verbose
```


## amiga_test

### Tool Description
Test for differential growth between two conditions

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT [-o OUTPUT] [-f FLAG] [-s SUBSET] [-t INTERVAL] -y
             HYPOTHESIS [-sfn SKIP_FIRST_N] [-tss TIME_STEP_SIZE]
             [-np NUMBER_PERMUTATIONS] [-fdr FALSE_DISCOVERY_RATE]
             [--confidence CONFIDENCE] [--subtract-blanks]
             [--subtract-control] [--verbose] [--fix-noise]
             [--include-gaussian-noise] [--sample-posterior] [--dont-plot]
             [--dont-plot-delta-od] [--save-cleaned-data]
             [--save-mapping-tables] [--save-gp-data] [--merge-summary]
             [--do-not-log-transform]

Test for differential growth between two conditions

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  -o OUTPUT, --output OUTPUT
  -f FLAG, --flag FLAG
  -s SUBSET, --subset SUBSET
  -t INTERVAL, --interval INTERVAL
  -y HYPOTHESIS, --hypothesis HYPOTHESIS
  -sfn SKIP_FIRST_N, --skip-first-n SKIP_FIRST_N
  -tss TIME_STEP_SIZE, --time-step-size TIME_STEP_SIZE
  -np NUMBER_PERMUTATIONS, --number-permutations NUMBER_PERMUTATIONS
  -fdr FALSE_DISCOVERY_RATE, --false-discovery-rate FALSE_DISCOVERY_RATE
  --confidence CONFIDENCE
                        Must be between 80 and 100. Default is 95.
  --subtract-blanks
  --subtract-control
  --verbose
  --fix-noise
  --include-gaussian-noise
  --sample-posterior
  --dont-plot
  --dont-plot-delta-od
  --save-cleaned-data
  --save-mapping-tables
  --save-gp-data
  --merge-summary
  --do-not-log-transform
```


## amiga_heatmap

### Tool Description
Plot a heatmap

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT -o OUTPUT [-s SUBSET] -v VALUE -x X_VARIABLE -y
             Y_VARIABLE [-p {mean,median}] [-f FILTER] [-t TITLE]
             [--kwargs KWARGS] [--verbose] [--save-filtered-table]
             [--width-height WIDTH_HEIGHT WIDTH_HEIGHT]
             [--colorbar-ratio COLORBAR_RATIO] [--color-x-by COLOR_X_BY]
             [--color-y-by COLOR_Y_BY] [--color-file-x COLOR_FILE_X]
             [--color-file-y COLOR_FILE_Y] [--color-scheme-x COLOR_SCHEME_X]
             [--color-scheme-y COLOR_SCHEME_Y] [--color-x-ratio COLOR_X_RATIO]
             [--color-y-ratio COLOR_Y_RATIO] [--missing-color MISSING_COLOR]
             [--cluster-x] [--cluster-y] [--sort-x-by SORT_X_BY]
             [--sort-y-by SORT_Y_BY] [--keep-rows-missing-data]
             [--keep-columns-missing-data]
             [--x-tick-labels-scale X_TICK_LABELS_SCALE]
             [--y-tick-labels-scale Y_TICK_LABELS_SCALE]
             [--color-bar-labels-scale COLOR_BAR_LABELS_SCALE]
             [--x-rotation X_ROTATION] [--highlight-labels HIGHLIGHT_LABELS]

Plot a heatmap

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  -o OUTPUT, --output OUTPUT
  -s SUBSET, --subset SUBSET
  -v VALUE, --value VALUE
  -x X_VARIABLE, --x-variable X_VARIABLE
  -y Y_VARIABLE, --y-variable Y_VARIABLE
  -p {mean,median}, --operation {mean,median}
  -f FILTER, --filter FILTER
  -t TITLE, --title TITLE
  --kwargs KWARGS
  --verbose
  --save-filtered-table
  --width-height WIDTH_HEIGHT WIDTH_HEIGHT
  --colorbar-ratio COLORBAR_RATIO
                        Proportion of figure size devoted to color bar.
                        Default is 0.1
  --color-x-by COLOR_X_BY
  --color-y-by COLOR_Y_BY
  --color-file-x COLOR_FILE_X
  --color-file-y COLOR_FILE_Y
  --color-scheme-x COLOR_SCHEME_X
  --color-scheme-y COLOR_SCHEME_Y
  --color-x-ratio COLOR_X_RATIO
                        Proportion of the heatmap devoted to the column color
                        labels. Default is 0.1
  --color-y-ratio COLOR_Y_RATIO
                        Proportion of the heatmap devoted to the row color
                        labels. Default is 0.1
  --missing-color MISSING_COLOR
  --cluster-x
  --cluster-y
  --sort-x-by SORT_X_BY
  --sort-y-by SORT_Y_BY
  --keep-rows-missing-data
                        Drops columsn that have any missing data
  --keep-columns-missing-data
                        Drops rows that have any missing data
  --x-tick-labels-scale X_TICK_LABELS_SCALE
                        Must be between 0 (smallest) and 1 (largest).
  --y-tick-labels-scale Y_TICK_LABELS_SCALE
                        Must be between 0 (smallest) and 1 (largest).
  --color-bar-labels-scale COLOR_BAR_LABELS_SCALE
                        Must be between 0 (smallest) and 1 (largest).
  --x-rotation X_ROTATION
  --highlight-labels HIGHLIGHT_LABELS
```


## amiga_get_confidence

### Tool Description
Compute confidence intervals for parameters or curves.

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] -i INPUT --type {Parameters,Curves}
             [--confidence CONFIDENCE] [--include-noise] [--over-write]
             [--verbose]

Compute confidence intervals for parameters or curves.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  --type {Parameters,Curves}
  --confidence CONFIDENCE
                        Must be between 80 and 100. Default is 95.
  --include-noise       Include the estimated measurement noise when computing
                        confidence interval (For Curves Only).
  --over-write          Over-write file otherwise a new copy is made with
                        "_confidence" suffix
  --verbose
```


## amiga_get_time

### Tool Description
Get time at which OD reaches a certain value

### Metadata
- **Docker Image**: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/firasmidani/amiga
- **Package**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amiga/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/firasmidani/amiga
- **Stars**: 16
### Original Help Text
```text
usage: amiga [-h] --gp-data GP_DATA --summary SUMMARY --threshold THRESHOLD
             [--curve-format {OD_Data,OD_Fit,GP_Input,GP_Output,OD_Growth_Fit,OD_Growth_Data,GP_Derivative}]

Get time at which OD reaches a certain value

options:
  -h, --help            show this help message and exit
  --gp-data GP_DATA
  --summary SUMMARY
  --threshold THRESHOLD
  --curve-format {OD_Data,OD_Fit,GP_Input,GP_Output,OD_Growth_Fit,OD_Growth_Data,GP_Derivative}
```


## Metadata
- **Skill**: not generated
