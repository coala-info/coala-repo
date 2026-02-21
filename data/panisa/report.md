# panisa CWL Generation Report

## panisa

### Tool Description
FAIL to generate CWL: panisa not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/panisa:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/panISa
- **Package**: https://anaconda.org/channels/bioconda/packages/panisa/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/panisa/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bvalot/panISa
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: panisa not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: panisa not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## panisa_panISa.py

### Tool Description
Search integrative element (IS) insertion on a genome using BAM alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/panisa:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/panISa
- **Package**: https://anaconda.org/channels/bioconda/packages/panisa/overview
- **Validation**: PASS
### Original Help Text
```text
usage: panISa.py [options] bam

Search integrative element (IS) insertion on a genome using BAM alignment

positional arguments:
  bam                   Alignment on BAM/SAM format

options:
  -h, --help            show this help message and exit
  -o [OUTPUT], --output [OUTPUT]
                        Return list of IS insertion by alignment,
                        default=stdout
  -q [QUALITY], --quality [QUALITY]
                        Min alignment quality value to conserve a clipped
                        read, default=20
  -m [MINIMUN], --minimun [MINIMUN]
                        Min number of clipped reads to look at IS on a
                        position, default=10
  -s [SIZE], --size [SIZE]
                        Maximun size of direct repeat region, default=20pb
  -p [PERCENTAGE], --percentage [PERCENTAGE]
                        Minimum percentage of same base to create consensus,
                        default=0.8
  -v, --version         show program's version number and exit
```

## panisa_ISFinder_search.py

### Tool Description
automate search IS homology in ISFinder from panISa output

### Metadata
- **Docker Image**: quay.io/biocontainers/panisa:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/panISa
- **Package**: https://anaconda.org/channels/bioconda/packages/panisa/overview
- **Validation**: PASS
### Original Help Text
```text
usage: ISFinder_search.py [options] file

automate search IS homology in ISFinder from panISa output

positional arguments:
  file                  PanISa result files to merge

options:
  -h, --help            show this help message and exit
  -o [OUTPUT], --output [OUTPUT]
                        Return potential IS found in ISFinder (default:stdout)
  -r [REMOVE], --remove [REMOVE]
                        Remove suffix at the end of the filename
                        (default:.txt)
  -l [LENGTH], --length [LENGTH]
                        Length of the IRR-IRL search (default:30)
  -i [0-100], --identity [0-100]
                        Percentage of expected identity (default:90)
  -e [EVALUE], --evalue [EVALUE]
                        Expected max evalue (default:1E-3)
  -a [0-100], --alignment [0-100]
                        Percentage of expected alignment (default:80)
  -v, --version         show program's version number and exit
```

