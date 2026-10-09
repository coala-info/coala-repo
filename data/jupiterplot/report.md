# jupiterplot CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jupiterplot_jupiter | PASS |  |

## jupiterplot_jupiter

### Tool Description
Jupiter Plot: draws a Circos plot of the alignment of a scaffold or contig assembly to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/jupiterplot:1.1--hdfd78af_0
- **Homepage**: https://github.com/JustinChu/JupiterPlot
- **Package**: https://anaconda.org/channels/bioconda/packages/jupiterplot/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jupiter name=<output prefix> ref=<reference.fa> fa=<scaffolds.fa> [options]
(jupiter is a wrapper around a makefile; options are name=value pairs)
Required:
  name=            output file prefix
  ref=             FASTA reference file
  fa=              FASTA contigs/scaffolds file
General:
  t=4              number of threads to use for minimap2
  sam=             use this SAM file instead of running minimap2
Karyotype options:
  m=100000         only use genomic reference chromosomes larger than this value
  ng=75            use largest scaffolds that are equal to 75% of the genome (0 = all)
  maxScaff=-1      instead of ng, filter by this number of scaffolds
  i=0              increment for colouring chromosomes (HSV colour shift 0-360; >360 = random)
  g=1              minimum gap size in reference to render
  gScaff=100000    minimum gap size in scaffolds to render
  labels=ref       show reference chromosome name "ref", scaffolds "scaf" or "both"
Link options:
  maxGap=100000        maximum alignment gap allowed to consider a region contiguous
  minBundleSize=50000  minimum size of a contiguous region to render
  MAPQ=50              maximum mapping quality allowed when filtering
  linkAlpha=5          alpha of links 1 = 17%, 2 = 33%, 3 = 50%, 4 = 67% and 5 = 83%
  profile=1            print run time of each step
(options taken from /usr/local/bin/jupiterplot/makefile in the image)
```

