# pegs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pegs | PASS | needs network: the tool downloads bedtools at run time (NetworkAccess set in the CWL) |
| pegs_mk_pegs_intervals | PASS |  |

## pegs

### Tool Description
Peak-set Enrichment Gene-set Analysis (PEGS)

### Metadata
- **Docker Image**: quay.io/biocontainers/pegs:0.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/pegjs/pegjs
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pegs/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pegjs/pegjs
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-axybolvx because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: pegs [-h] [--version] -p PEAK_SET_FILE [PEAK_SET_FILE ...] -g
            GENE_CLUSTER_FILE [GENE_CLUSTER_FILE ...] [-t TADS_FILE]
            [-d DISTANCE [DISTANCE ...]] [--name BASENAME]
            [-o OUTPUT_DIRECTORY] [-m HEATMAP] [-x XLSX] [--format FORMAT]
            [--x-label CLUSTERS_AXIS_LABEL] [--y-label PEAKSETS_AXIS_LABEL]
            [--color COLOR | --heatmap-palette OPTION=VALUE [OPTION=VALUE ...]]
            [-k] [--dump-raw-data]
            GENE_INTERVALS
pegs: error: the following arguments are required: GENE_INTERVALS, -p/--peaks, -g/--genes
```


## pegs_mk_pegs_intervals

### Tool Description
Make a BED file of gene intervals for PEGS from refGene annotation data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pegs:0.6.6--pyhdfd78af_0
- **Homepage**: https://github.com/fls-bioinformatics-core/pegs
- **Package**: https://anaconda.org/channels/bioconda/packages/pegs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mk_pegs_intervals [-h] [--version] REFGENE_FILE [GENE_INTERVAL_FILE]

positional arguments:
  REFGENE_FILE        refGene annotation data for the genome of interest
  GENE_INTERVAL_FILE  destination for output BED file with gene interval data
                      (default: '<REFGENE_FILE>_intervals.bed')

optional arguments:
  -h, --help          show this help message and exit
  --version           show program's version number and exit
```

## Metadata
- **Skill**: not generated
