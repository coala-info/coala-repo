# genrich CWL Generation Report

## genrich_Genrich

### Tool Description
Call peaks from SAM/BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/genrich:0.6.1--hed695b0_0
- **Homepage**: https://github.com/jsh58/Genrich
- **Package**: https://anaconda.org/channels/bioconda/packages/genrich/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genrich/overview
- **Total Downloads**: 24.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jsh58/Genrich
- **Stars**: N/A
### Original Help Text
```text
Error! Need input/output files
Usage: ./Genrich  -t <file>  -o <file>  [optional arguments]
Required arguments:
  -t  <file>       Input SAM/BAM file(s) for experimental sample(s)
  -o  <file>       Output peak file (in ENCODE narrowPeak format)
Optional I/O arguments:
  -c  <file>       Input SAM/BAM file(s) for control sample(s)
  -f  <file>       Output bedgraph-ish file for p/q values
  -k  <file>       Output bedgraph-ish file for pileups and p-values
  -b  <file>       Output BED file for reads/fragments/intervals
  -R  <file>       Output file for PCR duplicates (only with -r)
Filtering options:
  -r               Remove PCR duplicates
  -e  <arg>        Comma-separated list of chromosomes to exclude
  -E  <file>       Input BED file(s) of genomic regions to exclude
  -m  <int>        Minimum MAPQ to keep an alignment (def. 0)
  -s  <float>      Keep sec alns with AS >= bestAS - <float> (def. 0)
  -y               Keep unpaired alignments (def. false)
  -w  <int>        Keep unpaired alns, lengths changed to <int>
  -x               Keep unpaired alns, lengths changed to paired avg
Options for ATAC-seq:
  -j               Use ATAC-seq mode (def. false)
  -d  <int>        Expand cut sites to <int> bp (def. 100)
  -D               Skip Tn5 adjustments of cut sites (def. false)
Options for peak-calling:
  -p  <float>      Maximum p-value (def. 0.01)
  -q  <float>      Maximum q-value (FDR-adjusted p-value; def. 1)
  -a  <float>      Minimum AUC for a peak (def. 200.0)
  -l  <int>        Minimum length of a peak (def. 0)
  -g  <int>        Maximum distance between signif. sites (def. 100)
Other options:
  -X               Skip peak-calling
  -P               Call peaks directly from a log file (-f)
  -z               Option to gzip-compress output(s)
  -v               Option to print status updates/counts to stderr
```

