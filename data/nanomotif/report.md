# nanomotif CWL Generation Report

## nanomotif_motif_discovery

### Tool Description
Motif discovery from methylation data

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Total Downloads**: 20.5K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/MicrobialDarkMatter/nanomotif
- **Stars**: N/A
### Original Help Text
```text
usage: nanomotif motif_discovery
                                 (-c CONTIG_BIN | -f FILES [FILES ...] | -d DIRECTORY)
                                 [--extension EXTENSION] [--out OUT]
                                 [--methylation_threshold_low METHYLATION_THRESHOLD_LOW]
                                 [--methylation_threshold_high METHYLATION_THRESHOLD_HIGH]
                                 [--search_frame_size SEARCH_FRAME_SIZE]
                                 [--minimum_kl_divergence MINIMUM_KL_DIVERGENCE]
                                 [--min_motif_score MIN_MOTIF_SCORE]
                                 [--threshold_valid_coverage THRESHOLD_VALID_COVERAGE]
                                 [--min_motifs_bin MIN_MOTIFS_BIN]
                                 [-t THREADS] [-v] [--seed SEED] [-h]
                                 assembly pileup

positional arguments:
  assembly              path to the assembly file.
  pileup                path to the modkit pileup file.

contig bin arguments, use one of::
  -c CONTIG_BIN, --contig_bin CONTIG_BIN
                        TSV file specifying which bin contigs belong.
  -f FILES [FILES ...], --files FILES [FILES ...]
                        List of bin FASTA files with contig names as headers.
  -d DIRECTORY, --directory DIRECTORY
                        Directory containing bin FASTA files with contig names
                        as headers.
  --extension EXTENSION
                        File extension of the bin FASTA files if using -d
                        (DIRECTORY) argument. Default is '.fasta'.

Options:
  --out OUT             path to the output folder
  --methylation_threshold_low METHYLATION_THRESHOLD_LOW
                        A position is considered non-methylated if fraction of
                        methylation is below this threshold. Default: 0.3
  --methylation_threshold_high METHYLATION_THRESHOLD_HIGH
                        A position is considered methylated if fraction of
                        methylated reads is above this threshold. Default: 0.7
  --search_frame_size SEARCH_FRAME_SIZE
                        length of the sequnces sampled around confident
                        methylation sites. Default: 40
  --minimum_kl_divergence MINIMUM_KL_DIVERGENCE
                        Minimum KL-divergence for a position to considered for
                        expansion in motif search. Higher value means less
                        exhaustive, but faster search. Default: 0.05
  --min_motif_score MIN_MOTIF_SCORE
                        Minimum score for a motif to be kept after
                        identification. Default: 1.5
  --threshold_valid_coverage THRESHOLD_VALID_COVERAGE
                        Minimum valid base coverage (Nvalid_cov) for a
                        position to be considered. Default: 5
  --min_motifs_bin MIN_MOTIFS_BIN
                        Minimum number of motif observations in a bin.
                        Default: 50

general arguments:
  -t THREADS, --threads THREADS
                        Number of threads to use. Default is 1
  -v, --verbose         Increase output verbosity. (set logger to debug level)
  --seed SEED           Seed for random number generator. Default: 1
  -h, --help            show this help message and exit
```


## nanomotif_assembly

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: nanomotif [-h] [--version]
                 {motif_discovery, detect_contamination, include_contigs,
                 MTase-linker, check_installation} ...
nanomotif: error: argument {motif_discovery, detect_contamination, include_contigs, MTase-linker, check_installation}: invalid choice: 'assembly' (choose from motif_discovery, detect_contamination, include_contigs, MTase-linker, check_installation)
```


## nanomotif_detect_contamination

### Tool Description
Detects contamination in nanopore motif data.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanomotif detect_contamination [-h] --pileup PILEUP --assembly ASSEMBLY
                                      --bin_motifs BIN_MOTIFS --contig_bins
                                      CONTIG_BINS [-t THREADS]
                                      [--min_valid_read_coverage MIN_VALID_READ_COVERAGE]
                                      [--methylation_threshold METHYLATION_THRESHOLD]
                                      [--num_consensus NUM_CONSENSUS]
                                      [--force] [--write_bins]
                                      [--methylation_output_type {median,weighted_mean}]
                                      --out OUT
                                      [--contamination_file CONTAMINATION_FILE]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads to use for multiprocessing
  --min_valid_read_coverage MIN_VALID_READ_COVERAGE
                        Minimum read coverage for calculating methylation
                        [used with methylation_util executable]
  --methylation_threshold METHYLATION_THRESHOLD
                        Filtering criteria for trusting contig methylation. It
                        is the product of mean_read_coverage and
                        N_motif_observation. Higher value means stricter
                        criteria. [default: 24]
  --num_consensus NUM_CONSENSUS
                        Number of models that has to agree for classifying as
                        contaminant
  --force               Force override of motifs-scored-read-methylation.tsv.
                        If not set existing file will be used.
  --write_bins          If specified, new bins will be written to a bins
                        folder. Requires --assembly_file to be specified.
  --methylation_output_type {median,weighted_mean}
                        Specify whether to use the median of mean methylated
                        motif positions or the weighted mean. [default:
                        median]
  --contamination_file CONTAMINATION_FILE
                        Path to an existing contamination file if bins should
                        be outputtet as a post-processing step

Mandatory Arguments:
  --pileup PILEUP       Path to pileup.bed
  --assembly ASSEMBLY   Path to assembly file [fasta format required]
  --bin_motifs BIN_MOTIFS
                        Path to bin-motifs.tsv file
  --contig_bins CONTIG_BINS
                        Path to bins.tsv file for contig bins
  --out OUT             Path to output directory
```


## nanomotif_include_contigs

### Tool Description
Include contigs in the analysis based on methylation data.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanomotif include_contigs [-h] --pileup PILEUP --assembly ASSEMBLY
                                 --bin_motifs BIN_MOTIFS --contig_bins
                                 CONTIG_BINS [-t THREADS]
                                 [--min_valid_read_coverage MIN_VALID_READ_COVERAGE]
                                 [--methylation_threshold METHYLATION_THRESHOLD]
                                 [--num_consensus NUM_CONSENSUS] [--force]
                                 [--write_bins]
                                 [--methylation_output_type {median,weighted_mean}]
                                 --out OUT
                                 [--mean_model_confidence MEAN_MODEL_CONFIDENCE]
                                 [--contamination_file CONTAMINATION_FILE | --run_detect_contamination]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads to use for multiprocessing
  --min_valid_read_coverage MIN_VALID_READ_COVERAGE
                        Minimum read coverage for calculating methylation
                        [used with methylation_util executable]
  --methylation_threshold METHYLATION_THRESHOLD
                        Filtering criteria for trusting contig methylation. It
                        is the product of mean_read_coverage and
                        N_motif_observation. Higher value means stricter
                        criteria. [default: 24]
  --num_consensus NUM_CONSENSUS
                        Number of models that has to agree for classifying as
                        contaminant
  --force               Force override of motifs-scored-read-methylation.tsv.
                        If not set existing file will be used.
  --write_bins          If specified, new bins will be written to a bins
                        folder. Requires --assembly_file to be specified.
  --methylation_output_type {median,weighted_mean}
                        Specify whether to use the median of mean methylated
                        motif positions or the weighted mean. [default:
                        median]
  --mean_model_confidence MEAN_MODEL_CONFIDENCE
                        Mean probability between models for including contig.
                        Contigs above this value will be included. [default:
                        0.8]
  --contamination_file CONTAMINATION_FILE
                        Path to an existing contamination file to include in
                        the analysis
  --run_detect_contamination
                        Indicate that the detect_contamination workflow should
                        be run first

Mandatory Arguments:
  --pileup PILEUP       Path to pileup.bed
  --assembly ASSEMBLY   Path to assembly file [fasta format required]
  --bin_motifs BIN_MOTIFS
                        Path to bin-motifs.tsv file
  --contig_bins CONTIG_BINS
                        Path to bins.tsv file for contig bins
  --out OUT             Path to output directory
```


## nanomotif_MTase-linker

### Tool Description
MTase-linker commands

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanomotif MTase-linker [-h] {run,install} ...

options:
  -h, --help     show this help message and exit

MTase-linker commands:
  {run,install}
    run          Run the MTase-linker workflow
    install      Install additional dependencies for MTase-linker
```


## nanomotif_check_installation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: nanomotif check_installation [-h]

options:
  -h, --help  show this help message and exit
```


## nanomotif_installation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/nanomotif/
- **Package**: https://anaconda.org/channels/bioconda/packages/nanomotif/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: nanomotif [-h] [--version]
                 {motif_discovery, detect_contamination, include_contigs,
                 MTase-linker, check_installation} ...
nanomotif: error: argument {motif_discovery, detect_contamination, include_contigs, MTase-linker, check_installation}: invalid choice: 'installation' (choose from motif_discovery, detect_contamination, include_contigs, MTase-linker, check_installation)
```

