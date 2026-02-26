# tandem-genotypes CWL Generation Report

## tandem-genotypes

### Tool Description
Try to indicate genotypes of tandem repeats.

### Metadata
- **Docker Image**: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
- **Homepage**: https://github.com/mcfrith/tandem-genotypes
- **Package**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tandem-genotypes/overview
- **Total Downloads**: 33.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mcfrith/tandem-genotypes
- **Stars**: N/A
### Original Help Text
```text
Usage: tandem-genotypes [options] microsat.txt alignments.maf

Try to indicate genotypes of tandem repeats.

Options:
  -h, --help            show this help message and exit
  -g FILE, --genes=FILE
                        read genes from a genePred or BED file
  -o NUM, --output=NUM  output format: 1=original, 2=alleles (default=1)
  -m PROB, --mismap=PROB
                        ignore any alignment with mismap probability > PROB
                        (default=1e-06)
  --postmask=NUMBER     ignore mostly-lowercase alignments (default=1)
  -p BP, --promoter=BP  promoter length (default=300)
  -s N, --select=N      select: all repeats (0), non-intergenic repeats (1),
                        non-intergenic non-intronic repeats (2) (default=0)
  -u BP, --min-unit=BP  ignore repeats with unit shorter than BP (default=2)
  -f BP, --far=BP       require alignment >= BP beyond both sides of a repeat
                        (default=100)
  -n BP, --near=BP      count insertions <= BP beyond a repeat (default=60)
  --mode=LETTER         L=lenient, S=strict (default=L)
  --scores=FILE         importance scores for gene parts
  -v, --verbose         show more details
```

