# edd CWL Generation Report

## edd

### Tool Description
Enriched Domain Detector -- for analysis of ChIP-seq data. See documentation at https://github.com/CollasLab/edd for more info and tips.

### Metadata
- **Docker Image**: quay.io/biocontainers/edd:1.1.19--py27hc1659b7_0
- **Homepage**: http://github.com/CollasLab/edd
- **Package**: https://anaconda.org/channels/bioconda/packages/edd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/edd/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CollasLab/edd
- **Stars**: N/A
### Original Help Text
```text
usage: edd [-h] [--bin-size BIN_SIZE] [-n NUM_TRIALS] [-p NPROCS] [--fdr FDR]
           [-g GAP_PENALTY] [--config-file CONFIG_FILE] [--write-log-ratios]
           [--write-bin-scores] [-v]
           chrom_size unalignable_regions ip_bam input_bam output_dir

Enriched Domain Detector -- for analysis of ChIP-seq data. See documentation
at https://github.com/CollasLab/edd for more info and tips.

positional arguments:
  chrom_size            This must be a tab separated file with two columns.
                        The first column contains chromosome names and the
                        second contains the chromosome sizes.
  unalignable_regions   bed file marking regions to be excluded from the
                        analysis (such as centromeres).
  ip_bam                ChIP bam file
  input_bam             Input/control bam file
  output_dir            output directory, will be created if not existing.

optional arguments:
  -h, --help            show this help message and exit
  --bin-size BIN_SIZE   An integer specifying the bin size in KB. Will auto
                        select bin size based on input data if not specified.
  -n NUM_TRIALS, --num-trials NUM_TRIALS
                        Number of trials in monte carlo simulation
  -p NPROCS, --nprocs NPROCS
                        Number of processes to use for the monte carlo
                        simulation. One processes per physical CPU core is
                        recommended.
  --fdr FDR
  -g GAP_PENALTY, --gap-penalty GAP_PENALTY
                        Leave unspecificed for auto-estimation. Adjusts how
                        sensitive EDD is to heterogeneity within domains.
                        Depends on Signal/Noise ratio of source files and on
                        the interests of the researcher. A "low" value favors
                        large enriched domains with more heterogeneity. A
                        "high" value favors smaller enriched domains devoid of
                        heterogeneity.
  --config-file CONFIG_FILE
                        Path to user specified EDD configuration file. See EDD
                        manual section about configuration for more
                        information.
  --write-log-ratios    Write log ratios to file.
  --write-bin-scores    Write bin scores to file.
  -v, --version         Print version and exit
```

