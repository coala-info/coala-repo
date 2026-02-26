# gmm-demux CWL Generation Report

## gmm-demux_GMM-demux

### Tool Description
GMM-Demux Initialization

### Metadata
- **Docker Image**: quay.io/biocontainers/gmm-demux:0.2.2.3--pyh7e72e81_1
- **Homepage**: https://github.com/CHPGenetics/GMM-demux
- **Package**: https://anaconda.org/channels/bioconda/packages/gmm-demux/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmm-demux/overview
- **Total Downloads**: 713
- **Last updated**: 2026-01-12
- **GitHub**: https://github.com/CHPGenetics/GMM-demux
- **Stars**: N/A
### Original Help Text
```text
==============================GMM-Demux Initialization==============================
usage: GMM-demux [-h] [-k SKIP] [-x EXTRACT] [-o OUTPUT] [-f FULL] [-c]
                 [-t THRESHOLD] [-s SIMPLIFIED] [-u SUMMARY] [-r REPORT]
                 [-e EXAMINE] [-a AMBIGUOUS] [-rs RANDOM_SEED]
                 [input_path ...] [hto_array ...]

positional arguments:
  input_path            The input path of mtx files from cellRanger pipeline.
  hto_array             Names of the HTO tags, separated by ','.

options:
  -h, --help            show this help message and exit
  -k, --skip SKIP       Load a full classification report and skip the mtx
                        folder. Requires a path argument to the full report
                        folder. When specified, the user no longer needs to
                        provide the mtx folder.
  -x, --extract EXTRACT
                        Names of the HTO tag(s) to extract, separated by ','.
                        Joint HTO samples are combined with '+', such as
                        'HTO_1+HTO_2'.
  -o, --output OUTPUT   The path for storing the Same-Sample-Droplets (SSDs).
                        SSDs are stored in mtx format. Requires a path
                        argument.
  -f, --full FULL       Generate the full classification report. Requires a
                        path argument.
  -c, --csv             Take input in csv format, instead of mmx format.
  -t, --threshold THRESHOLD
                        Provide the confidence threshold value. Requires a
                        float in (0,1). Default value: 0.8
  -s, --simplified SIMPLIFIED
                        Generate the simplified classification report.
                        Requires a path argument.
  -u, --summary SUMMARY
                        Generate the statstic summary of the dataset.
                        Including MSM, SSM rates. Requires an estimated total
                        number of cells in the assay as input.
  -r, --report REPORT   Store the data summary report. Requires a file
                        argument. Only executes if -u is set.
  -e, --examine EXAMINE
                        Provide the cell list. Requires a file argument. Only
                        executes if -u is set.
  -a, --ambiguous AMBIGUOUS
                        The estimated chance of having a phony GEM getting
                        included in a pure type GEM cluster by the clustering
                        algorithm. Requires a float in (0, 1). Default value:
                        0.05. Only executes if -e executes.
  -rs, --random_seed RANDOM_SEED
                        If provided, this is passed to the GaussianMixture
                        random_state parameter.
```

