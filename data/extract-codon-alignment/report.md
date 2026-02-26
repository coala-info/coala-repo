# extract-codon-alignment CWL Generation Report

## extract-codon-alignment_extract_codon_alignment

### Tool Description
To extract some codon positions (1st, 2nd, 3rd) from a CDS alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
- **Homepage**: https://github.com/linzhi2013/extract_codon_alignment
- **Package**: https://anaconda.org/channels/bioconda/packages/extract-codon-alignment/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/extract-codon-alignment/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linzhi2013/extract_codon_alignment
- **Stars**: N/A
### Original Help Text
```text
usage: extract_codon_alignment [-h] --alignedCDS <file>
                               [--aln_format <format>]
                               [--codonPoses {1,2,3,12,13,23}] --outAln <file>

To extract some codon positions (1st, 2nd, 3rd) from a CDS alignment.

optional arguments:
  -h, --help            show this help message and exit
  --alignedCDS <file>   The CDS alignment.
  --aln_format <format>
                        the file format for the CDS alignment. Anything
                        accepted by BioPython is fine [fasta]
  --codonPoses {1,2,3,12,13,23}
                        Codon position(s) to be extracted [12]
  --outAln <file>       output file name
```

