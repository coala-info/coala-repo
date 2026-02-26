# simple_sv_annotation CWL Generation Report

## simple_sv_annotation_simple_sv_annotation.py

### Tool Description
Simplify SV annotations from snpEff to highlight exon impact. Requires the
pyvcf module.

### Metadata
- **Docker Image**: quay.io/biocontainers/simple_sv_annotation:2019.02.18--py_0
- **Homepage**: https://github.com/AstraZeneca-NGS/simple_sv_annotation
- **Package**: https://anaconda.org/channels/bioconda/packages/simple_sv_annotation/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/simple_sv_annotation/overview
- **Total Downloads**: 76.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AstraZeneca-NGS/simple_sv_annotation
- **Stars**: N/A
### Original Help Text
```text
usage: simple_sv_annotation.py [-h] [--gene_list GENE_LIST]
                               [--known_fusion_pairs KNOWN_FUSION_PAIRS]
                               [--known_fusion_promiscuous KNOWN_FUSION_PROMISCUOUS]
                               [--output OUTPUT] [--exonNums EXONNUMS]
                               vcf

Simplify SV annotations from snpEff to highlight exon impact. Requires the
pyvcf module.

positional arguments:
  vcf                   VCF file with snpEff annotations

optional arguments:
  -h, --help            show this help message and exit
  --gene_list GENE_LIST, -g GENE_LIST
                        File with names of genes (one per line) for
                        prioritisation
  --known_fusion_pairs KNOWN_FUSION_PAIRS, -k KNOWN_FUSION_PAIRS
                        File with known fusion gene pairs, one pair per line
                        delimited by comma
  --known_fusion_promiscuous KNOWN_FUSION_PROMISCUOUS, -p KNOWN_FUSION_PROMISCUOUS
                        File with known promiscuous fusion genes, one gene
                        name per line
  --output OUTPUT, -o OUTPUT
                        Output file name (must not exist). Does not support
                        bgzipped output. Use "-" for stdout.
                        [<invcf>.simpleann.vcf]
  --exonNums EXONNUMS, -e EXONNUMS
                        List of custom exon numbers. A transcript listed in
                        this file will be annotated with the numbers found in
                        this file, not the numbers found in the snpEff result
```

