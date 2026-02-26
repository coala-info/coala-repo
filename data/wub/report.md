# wub CWL Generation Report

## wub_bam_accuracy.py

### Tool Description
Produce accuracy statistics of the input BAM file. Calculates global accuracy and identity and various per-read statistics. The input BAM file must be sorted by coordinates and indexed.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Total Downloads**: 27.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/wub
- **Stars**: N/A
### Original Help Text
```text
usage: bam_accuracy.py [-h] [-c region] [-g global_tsv] [-l read_tsv]
                       [-t bam_tag] [-q aqual] [-e] [-r report_pdf]
                       [-p results_pickle] [-Q]
                       bam

Produce accuracy statistics of the input BAM file. Calculates global accuracy
and identity and various per-read statistics. The input BAM file must be
sorted by coordinates and indexed.

positional arguments:
  bam                Input BAM file.

optional arguments:
  -h, --help         show this help message and exit
  -c region          BAM region (None).
  -g global_tsv      Tab separated file to save global statistics (None).
  -l read_tsv        Tab separated file to save per-read statistics (None).
  -t bam_tag         Dataset tag (BAM basename).
  -q aqual           Minimum alignment quality (0).
  -e                 Include hard and soft clipps in alignment length when
                     calculating accuracy (False).
  -r report_pdf      Report PDF (bam_accuracy.pdf).
  -p results_pickle  Save pickled results in this file (None).
  -Q                 Be quiet and do not print progress bar (False).
```


## wub_bam_cov.py

### Tool Description
Produce refrence coverage table.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_cov.py [-h] -f reference [-c region] [-t tsv] [-q aqual] [-Q] bam

Produce refrence coverage table.

positional arguments:
  bam           Input BAM file.

optional arguments:
  -h, --help    show this help message and exit
  -f reference  Reference fasta.
  -c region     BAM region (None).
  -t tsv        Output TSV (bam_cov.tsv).
  -q aqual      Minimum alignment quality (0).
  -Q            Be quiet and do not show progress bars.
```


## wub_bam_frag_coverage.py

### Tool Description
Produce aggregated and individual plots of fragment coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_frag_coverage.py [-h] -f reference [-c region] [-i intervals]
                            [-b bins] [-x] [-o] [-t bam_tag] [-q aqual]
                            [-l cov80_tsv] [-g glob_cov80_tsv] [-r report_pdf]
                            [-p results_pickle] [-Q]
                            bam

Produce aggregated and individual plots of fragment coverage.

positional arguments:
  bam                Input BAM file.

optional arguments:
  -h, --help         show this help message and exit
  -f reference       Reference fasta.
  -c region          BAM region (None).
  -i intervals       Length intervals ().
  -b bins            Number of bins (None = auto).
  -x                 Plot per-reference information.
  -o                 Do not take log of coverage.
  -t bam_tag         Dataset tag (BAM basename).
  -q aqual           Minimum alignment quality (0).
  -l cov80_tsv       Tab separated file with per-chromosome cov80 scores
                     (None). Requires the -x option to be specified.
  -g glob_cov80_tsv  Tab separated file with global cov80 score (None).
  -r report_pdf      Report PDF (bam_frag_coverage.pdf).
  -p results_pickle  Save pickled results in this file (None).
  -Q                 Be quiet and do not show progress bars.
```

