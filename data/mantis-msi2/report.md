# mantis-msi2 CWL Generation Report

## mantis-msi2

### Tool Description
Microsatellite Analysis for Normal-Tumor InStability (v2.0.0)

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis-msi2:2.0.0--h9948957_3
- **Homepage**: https://github.com/nh13/MANTIS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis-msi2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mantis-msi2/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/nh13/MANTIS2
- **Stars**: N/A
### Original Help Text
```text
Microsatellite Analysis for Normal-Tumor InStability (v2.0.0)
usage: mantis-msi2 [-h] [-cfg CFG] -n NORMAL -t TUMOR [--threads THREADS]
                   [-b BEDFILE] [-o OUTPUT] [-mrq MRQ] [-mlq MLQ] [-mrl MRL]
                   [-mlc MLC] [-mrr MRR] [-sd SD] [--genome GENOME]
                   [--difference-threshold DIF_THRESHOLD]
                   [--distance-threshold EUC_THRESHOLD]
                   [--dissimilarity-threshold COS_THRESHOLD]

Microsatellite Analysis for Normal-Tumor InStability (v2.0.0)

optional arguments:
  -h, --help            show this help message and exit
  -cfg CFG, --config CFG
                        Configuration file.
  -n NORMAL, --normal NORMAL
                        Normal input BAM file.
  -t TUMOR, --tumor TUMOR
                        Tumor input BAM file.
  --threads THREADS     How many threads (processes) to use.
  -b BEDFILE, --bedfile BEDFILE
                        Input BED file.
  -o OUTPUT, --output OUTPUT
                        Output filename.
  -mrq MRQ, --min-read-quality MRQ
                        Minimum average read quality.
  -mlq MLQ, --min-locus-quality MLQ
                        Minimum average locus quality.
  -mrl MRL, --min-read-length MRL
                        Minimum (unclipped/unmasked) read length.
  -mlc MLC, --min-locus-coverage MLC
                        Minimum coverage required for each of the normal and
                        tumor results.
  -mrr MRR, --min-repeat-reads MRR
                        Minimum reads supporting a specific repeat count.
  -sd SD, --standard-deviations SD
                        Standard deviations from mean before repeat count is
                        considered an outlier
  --genome GENOME       Path to reference genome (FASTA).
  --difference-threshold DIF_THRESHOLD
                        Default difference threshold value for calling a
                        sample unstable.
  --distance-threshold EUC_THRESHOLD
                        Default distance threshold value for calling a sample
                        unstable.
  --dissimilarity-threshold COS_THRESHOLD
                        Default dissimilarity threshold value for calling a
                        sample unstable.
```

