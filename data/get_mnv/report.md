# get_mnv CWL Generation Report

## get_mnv

### Tool Description
Identifies multiple SNVs within the same codon, reclassifies them as MNVs, and accurately computes resulting amino acid changes from genomic reads

### Metadata
- **Docker Image**: quay.io/biocontainers/get_mnv:1.0.0--ha7a4ace_1
- **Homepage**: https://github.com/PathoGenOmics-Lab/get_mnv
- **Package**: https://anaconda.org/channels/bioconda/packages/get_mnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/get_mnv/overview
- **Total Downloads**: 891
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PathoGenOmics-Lab/get_mnv
- **Stars**: N/A
### Original Help Text
```text
Identifies multiple SNVs within the same codon, reclassifies them as MNVs, and accurately computes resulting amino acid changes from genomic reads

Usage: get_mnv [OPTIONS] --vcf <VCF_FILE> --fasta <FASTA_FILE> --genes <GENES_FILE>

Options:
  -v, --vcf <VCF_FILE>      VCF file with SNPs
  -b, --bam <BAM_FILE>      BAM file with aligned reads (optional)
  -f, --fasta <FASTA_FILE>  FASTA file with reference sequence
  -g, --genes <GENES_FILE>  File with gene information
  -q, --quality <QUALITY>   Minimum Phred quality score (default: 20) [default: 20]
  -h, --help                Print help
  -V, --version             Print version
```

