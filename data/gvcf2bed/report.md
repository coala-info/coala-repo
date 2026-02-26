# gvcf2bed CWL Generation Report

## gvcf2bed

### Tool Description
Create a BED file from a gVCF. Regions are based on a minimum genotype quality. The gVCF file must contain a GQ field in its FORMAT fields. GQ scores of non-variants records have a different distribution from the GQ score distribution of variant records. Hence, an option is provided to set a different threshold for non-variant positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/gvcf2bed:0.3.1--py_0
- **Homepage**: https://github.com/sndrtj/gvcf2bed
- **Package**: https://anaconda.org/channels/bioconda/packages/gvcf2bed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gvcf2bed/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sndrtj/gvcf2bed
- **Stars**: N/A
### Original Help Text
```text
usage: gvcf2bed [-h] -I INPUT -O OUTPUT [-s SAMPLE] [-q QUALITY]
                [-nq NON_VARIANT_QUALITY] [-b]

Create a BED file from a gVCF. Regions are based on a minimum genotype
quality. The gVCF file must contain a GQ field in its FORMAT fields. GQ scores
of non-variants records have a different distribution from the GQ score
distribution of variant records. Hence, an option is provided to set a
different threshold for non-variant positions.

optional arguments:
  -h, --help            show this help message and exit
  -I INPUT, --input INPUT
                        Input gVCF
  -O OUTPUT, --output OUTPUT
                        Output bed file
  -s SAMPLE, --sample SAMPLE
                        Sample name in VCF file to use. Will default to first
                        sample (alphabetically) if not supplied
  -q QUALITY, --quality QUALITY
                        Minimum genotype quality (default 20)
  -nq NON_VARIANT_QUALITY, --non-variant-quality NON_VARIANT_QUALITY
                        Minimum genotype quality for non-variant records
                        (default 20)
  -b, --bedgraph        Output in bedgraph mode
```

