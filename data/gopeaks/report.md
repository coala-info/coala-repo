# gopeaks CWL Generation Report

## gopeaks

### Tool Description
GoPeaks is a peak caller designed for CUT&TAG/CUT&RUN sequencing
data. GoPeaks by default works best with narrow peaks such as
H3K4me3 and transcription factors. GoPeaks can be used with the
"--broad" flag to call broad peaks like H3K27Ac/H3K4me1. We
encourage users to explore the parameters of GoPeaks to analyze
their data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gopeaks:1.0.0--h047eeb3_3
- **Homepage**: https://github.com/maxsonBraunLab/gopeaks
- **Package**: https://anaconda.org/channels/bioconda/packages/gopeaks/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gopeaks/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxsonBraunLab/gopeaks
- **Stars**: N/A
### Original Help Text
```text
unknown arguments --h
usage: GoPeaks [-h|--help] [-b|--bam "<value>"] [-c|--control "<value>"]
               [-s|--chromsize "<value>"] [-m|--mdist <integer>] [-r|--minreads
               <integer>] [-p|--pval <float>] [-t|--step <integer>] [-l|--slide
               <integer>] [-w|--minwidth <integer>] [-o|--prefix "<value>"]
               [-v|--version] [--broad] [--verbose]

               GoPeaks is a peak caller designed for CUT&TAG/CUT&RUN sequencing
               data. GoPeaks by default works best with narrow peaks such as
               H3K4me3 and transcription factors. GoPeaks can be used with the
               "--broad" flag to call broad peaks like H3K27Ac/H3K4me1. We
               encourage users to explore the parameters of GoPeaks to analyze
               their data.

Arguments:

  -h  --help       Print help information
  -b  --bam        Input BAM file (must be paired-end reads)
  -c  --control    Input BAM file with control signal to be normalized (e.g.
                   IgG, Input)
  -s  --chromsize  Chromosome sizes for the genome if not found in the bam
                   header
  -m  --mdist      Merge peaks within <mdist> base pairs. Default: 1000
  -r  --minreads   Test genome bins with at least <minreads> read pairs..
                   Default: 15
  -p  --pval       Define significance threshold <pval> with multiple
                   hypothesis correction via Benjamini-Hochberg. Default: 0.05
  -t  --step       Bin size for coverage bins. Default: 100
  -l  --slide      Slide size for coverage bins. Default: 50
  -w  --minwidth   Minimum width (bp) of a peak. Default: 150
  -o  --prefix     Output prefix to write peaks and metrics file. Default:
                   sample
  -v  --version    Print the current GoPeaks version
      --broad      Run GoPeaks on broad marks (--step 5000 & --slide 1000)
      --verbose    Run GoPeaks in verbose mode.
```

