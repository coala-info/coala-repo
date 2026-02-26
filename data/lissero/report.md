# lissero CWL Generation Report

## lissero

### Tool Description
In silico serogroup prediction for L. monocytogenes. Alleles: lmo1118, lmo0737, ORF2819, ORF2110, Prs

### Metadata
- **Docker Image**: quay.io/biocontainers/lissero:0.4.10--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/lissero
- **Package**: https://anaconda.org/channels/bioconda/packages/lissero/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lissero/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/MDU-PHL/lissero
- **Stars**: N/A
### Original Help Text
```text
Usage: lissero [OPTIONS] FASTA...

  In silico serogroup prediction for L. monocytogenes. Alleles: lmo1118,
  lmo0737, ORF2819, ORF2110, Prs

  References:

  * Doumith et al. Differentiation of the major Listeria monocytogenes
  serovars by multiplex PCR. J Clin Microbiol, 2004; 42:8; 3819-22

Options:
  -h, --help              Show this message and exit.
  -s, --serotype_db TEXT  [default: /usr/local/lib/python3.14/site-
                          packages/lissero/db]
  --min_id FLOAT          Minimum percent identity to accept a match. [0-100]
                          [default: 95.0]
  --min_cov FLOAT         Minimum coverage of the gene to accept a match.
                          [0-100]  [default: 95.0]
  --debug
  --logfile TEXT          Save log to a file instead of printing to stderr
  --version               Show Version Information
```

