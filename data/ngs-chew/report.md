# ngs-chew CWL Generation Report

## ngs-chew_compare

### Tool Description
Perform fingeprint comparison.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/ngs-chew
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-chew/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngs-chew/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/ngs-chew
- **Stars**: N/A
### Original Help Text
```text
Usage: ngs-chew compare [OPTIONS] [FINGERPRINTS]...

  Perform fingeprint comparison.

Options:
  --output-prefix TEXT      Path to comparison file.
  --min-mask-ones INTEGER   Minimal number of ones in mask.
  --max-mask-ones INTEGER   Maximal number of ones in mask.
  --by-path / --no-by-path  Use path as fingerprint name.
  --help                    Show this message and exit.
```


## ngs-chew_fingerprint

### Tool Description
Compute fingerprint to numpy .npz files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/ngs-chew
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-chew/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ngs-chew fingerprint [OPTIONS]

  Compute fingerprint to numpy .npz files.

Options:
  --min-coverage INTEGER          Minimal required coverage.
  --reference TEXT                Path to reference FASTA file.  [required]
  --output-fingerprint TEXT       Path to output .npz file (extension will be
                                  added automatically if necessary)
                                  [required]
  --output-aafs / --no-output-aafs
                                  Write alternate allele fractions to .npz
                                  file.
  --input-bam TEXT                Path to input BAM file.  [required]
  --genome-release TEXT           Genome release used.
  --max-sites INTEGER             Maximal number of sites to consider.
  --write-vcf / --no-write-vcf    Enable writing of call VCF.
  --step-autosomal-snps / --no-step-autosomal-snps
                                  Enable autosomal SNP step (default: yes)
  --step-chrx-snps / --no-step-chrx-snps
                                  Enable chrX SNP step (default: yes)
  --step-samtools-idxstats / --no-step-samtools-idxstats
                                  Enable samtools idxstats step (default: yes)
  --step-bcftools-roh / --no-step-bcftools-roh
                                  Enable bcftools roh step (default: yes)
  --write-vcf / --no-write-vcf    Enable writing of call VCF.
  --help                          Show this message and exit.
```


## ngs-chew_plot-compare

### Tool Description
Plot result of 'ngs-chew compare'.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/ngs-chew
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-chew/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ngs-chew plot-compare [OPTIONS] COMPARE_OUT OUT_HTML

  Plot result of 'ngs-chew compare'.

Options:
  --title TEXT  title to use for the output HTML file.
  --help        Show this message and exit.
```


## ngs-chew_plot-var-het

### Tool Description
Plot var(het) metric from .npz files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/ngs-chew
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-chew/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ngs-chew plot-var-het [OPTIONS] STATS_OUT OUT_HTML

  Plot var(het) metric from .npz files.

Options:
  --title TEXT  title to use for the output HTML file.
  --help        Show this message and exit.
```


## ngs-chew_stats

### Tool Description
Compute statistics from fingerprint .npz files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/ngs-chew
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-chew/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ngs-chew stats [OPTIONS] [FINGERPRINTS]...

  Compute statistics from fingerprint .npz files.

Options:
  --output TEXT  Path to output file.
  --help         Show this message and exit.
```


## Metadata
- **Skill**: generated
