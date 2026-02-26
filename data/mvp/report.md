# mvp CWL Generation Report

## mvp

### Tool Description
Motif-Variant Probe: detect motif gain and loss due to mutations

### Metadata
- **Docker Image**: quay.io/biocontainers/mvp:0.4.3--py35_0
- **Homepage**: https://gitlab.com/LPCDRP/motif-variants
- **Package**: https://anaconda.org/channels/bioconda/packages/mvp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mvp/overview
- **Total Downloads**: 12.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: mvp [-h] [-o OUTFILE] -r REFERENCE (-f MOTIF_FILE | -m MOTIF_LIST)
           [-t {dna,aa}]
           infile

Motif-Variant Probe: detect motif gain and loss due to mutations

positional arguments:
  infile                vcf or vcf.gz file containing mutations (default:
                        stdin)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        results table (default: stdout)
  -r REFERENCE, --reference REFERENCE
                        reference sequence in fasta format
  -f MOTIF_FILE, --motif-file MOTIF_FILE
                        file containing a list of motifs to check
  -m MOTIF_LIST, --motif-list MOTIF_LIST
                        a comma-delimited string of motifs to check
  -t {dna,aa}, --sequence-type {dna,aa}
                        DNA or amino acid (default: dna)
```

