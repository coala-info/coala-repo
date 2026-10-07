# chromograph CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chromograph | PASS |  |

## chromograph

### Tool Description
Chromograph plots genomic data (coverage, autozygosity, homozygous SNP fraction, ideograms, UPD regions and sites) on chromosomes as PNG images.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromograph:1.3.1--pyhdfd78af_2
- **Homepage**: https://github.com/Clinical-Genomics/chromograph
- **Package**: https://anaconda.org/channels/bioconda/packages/chromograph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chromograph/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Clinical-Genomics/chromograph
- **Stars**: N/A
### Original Help Text
```text
usage: chromograph [-h] [-a FILE] [-c FILE] [-f FILE] [-i FILE] [-m FILE]
                   [-r FILE] [-s FILE] [--step STEP] [--version] [-d FILE]
                   [-e] [-k FILE] [-n] [-u CHUNK] [-x] [--small] [--medium]
                   [--large]

optional arguments:
  -h, --help            show this help message and exit
  -a FILE, --autozyg FILE
                        Plot regions of autozygosity from bed file [OPERATION]
  -c FILE, --coverage FILE
                        Plot coverage from fixed step wig file [OPERATION]
  -f FILE, --fracsnp FILE
                        Plot fraction of homozygous SNPs from wig file
                        [OPERATION]
  -i FILE, --ideogram FILE
                        Plot ideograms from bed-file on format ['chrom',
                        'start', 'end', 'name', 'gStain'] [OPERATION]
  -m FILE, --exom FILE  Plot exom coverage from bed file [OPERATION]
  -r FILE, --regions FILE
                        Plot UPD regions from bed file [OPERATION]
  -s FILE, --sites FILE
                        Plot UPD sites from bed file [OPERATION]
  --step STEP           fixed step size (default 5000)
  --version             Display program version (1.3.1) and exit.
  -d FILE, --outd FILE  output dir
  -e, --euploid         Always output an euploid amount of files -even if some
                        are empty
  -k FILE, --rgb FILE   Set color (RGB hex, only with --coverage option)
  -n, --norm            Normalize data (wig/coverage)
  -u CHUNK, --chunk CHUNK
                        Set Matplotlib.agg.path.chunksize (default 10000)
  -x, --combine         Write all graphs to one file (default one plot per
                        file)
  --small
  --medium
  --large

One OPERATION Command is needed for Chromograph to produce output
```


## Metadata
- **Skill**: generated
