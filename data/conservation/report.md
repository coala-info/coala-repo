# conservation CWL Generation Report

## conservation_codon

### Tool Description
Codon conservation analysis from Pfam domains and CDS sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/conservation:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/hanjunlee21/conservation
- **Package**: https://anaconda.org/channels/bioconda/packages/conservation/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conservation/overview
- **Total Downloads**: 104
- **Last updated**: 2025-04-23
- **GitHub**: https://github.com/hanjunlee21/conservation
- **Stars**: N/A
### Original Help Text
```text
usage: conservation codon [-h] -d DOMAIN -c CDS -o OUTPUT [-t THREADS]
                          [-q FDR] [-s CONSERVEDNESS] [-r DPI]

Codon conservation analysis from Pfam domains and CDS sequences.

options:
  -h, --help            show this help message and exit
  -d, --domain DOMAIN   FASTA file of domain sequences (e.g., Pfam)
  -c, --cds CDS         Comma-separated list of CDS fasta files for each
                        organism
  -o, --output OUTPUT   Output directory to store results
  -t, --threads THREADS
                        Number of parallel threads (default: 1)
  -q, --fdr FDR         FDR cutoff (default: 0.05 / num_records)
  -s, --conservedness CONSERVEDNESS
                        Identity ratio threshold (default: mean + 2*std)
  -r, --dpi DPI         DPI for all generated PDF files (default: 300)
```

