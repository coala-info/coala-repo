# pyloh CWL Generation Report

## pyloh_PyLOH.py preprocess

### Tool Description
Preprocesses BAM files for PyLOH analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyloh:1.4.3--py27_0
- **Homepage**: https://github.com/uci-cbcl/PyLOH
- **Package**: https://anaconda.org/channels/bioconda/packages/pyloh/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyloh/overview
- **Total Downloads**: 20.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/uci-cbcl/PyLOH
- **Stars**: N/A
### Original Help Text
```text
usage: PyLOH preprocess [-h] [--segments_bed SEGMENTS_BED] [--WES]
                        [--min_depth MIN_DEPTH]
                        [--min_base_qual MIN_BASE_QUAL]
                        [--min_map_qual MIN_MAP_QUAL]
                        [--process_num PROCESS_NUM]
                        reference_genome normal_bam tumor_bam filename_base

positional arguments:
  reference_genome      FASTA file for reference genome.
  normal_bam            BAM file for normal sample.
  tumor_bam             BAM file for tumor sample.
  filename_base         Base name of preprocessed files to be created.

optional arguments:
  -h, --help            show this help message and exit
  --segments_bed SEGMENTS_BED
                        BED file for segments. If not provided, use autosomes
                        as segments. Default is None.
  --WES                 Flag indicating whether the BAM files are whole exome
                        sequencing(WES) or not. If not provided, the BAM files
                        are assumed to be whole genome sequencing(WGS).
                        Default is False.
  --min_depth MIN_DEPTH
                        Minimum reads depth required for both normal and tumor
                        samples. Default is 20.
  --min_base_qual MIN_BASE_QUAL
                        Minimum base quality required. Default is 10.
  --min_map_qual MIN_MAP_QUAL
                        Minimum mapping quality required. Default is 10.
  --process_num PROCESS_NUM
                        Number of processes to launch for preprocessing.
                        Default is 1.
```


## pyloh_PyLOH.py run_model

### Tool Description
Run the PyLOH model training.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyloh:1.4.3--py27_0
- **Homepage**: https://github.com/uci-cbcl/PyLOH
- **Package**: https://anaconda.org/channels/bioconda/packages/pyloh/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyLOH run_model [-h] [--allelenumber_max ALLELENUMBER_MAX]
                       [--priors PRIORS] [--max_iters MAX_ITERS]
                       [--stop_value STOP_VALUE]
                       filename_base

positional arguments:
  filename_base         Base name of preprocessed files created.

optional arguments:
  -h, --help            show this help message and exit
  --allelenumber_max ALLELENUMBER_MAX
                        Maximum copy number of each allele allows to take.
                        Default is 2.
  --priors PRIORS       File of the prior distribution. If not provided, use
                        uniform prior. Default is None.
  --max_iters MAX_ITERS
                        Maximum number of iterations for training. Default is
                        100.
  --stop_value STOP_VALUE
                        Stop value of the EM algorithm for training. If the
                        change of log-likelihood is lower than this value,
                        stop training. Default is 1e-7.
```


## pyloh_PyLOH.py BAF_heatmap

### Tool Description
Generates a BAF heatmap from preprocessed files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyloh:1.4.3--py27_0
- **Homepage**: https://github.com/uci-cbcl/PyLOH
- **Package**: https://anaconda.org/channels/bioconda/packages/pyloh/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PyLOH BAF_heatmap [-h] filename_base

positional arguments:
  filename_base  Base name of preprocessed files created.

optional arguments:
  -h, --help     show this help message and exit
```


## Metadata
- **Skill**: generated
