# strvctvre CWL Generation Report

## strvctvre_StrVCTVRE.py

### Tool Description
Annotate the pathogenicity of exonic deletions and duplications in GRCh38 (default) or GRCh37.

### Metadata
- **Docker Image**: quay.io/biocontainers/strvctvre:1.10--pyh7e72e81_0
- **Homepage**: https://github.com/andrewSharo/StrVCTVRE/tree/master
- **Package**: https://anaconda.org/channels/bioconda/packages/strvctvre/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strvctvre/overview
- **Total Downloads**: 91
- **Last updated**: 2025-09-17
- **GitHub**: https://github.com/andrewSharo/StrVCTVRE
- **Stars**: N/A
### Original Help Text
```text
usage: StrVCTVRE.py [-h] -i /path/to/input/file -o /path/to/output/file
                    [-f {vcf,bed}] [-p path/to/hg38.phyloP100way.bw]
                    [-a {GRCh37,GRCh38}] [-l /path/to/liftover]

StrVCTVRE: version 1.8
Author: Andrew Sharo (sharo@berkeley.edu)
Annotate the pathogenicity of exonic deletions and duplications in GRCh38 (default) or GRCh37.

options:
  -h, --help            show this help message and exit
  -i /path/to/input/file, --input /path/to/input/file
                        Input file path
  -o /path/to/output/file, --output /path/to/output/file
                        Output file path
  -f {vcf,bed}, --format {vcf,bed}
                        Input file format, either vcf or bed, defaults to vcf
                        when not provided
  -p path/to/hg38.phyloP100way.bw, --phyloP path/to/hg38.phyloP100way.bw
                        phyloP file path, defaults to
                        'data/hg38.phyloP100way.bw' when not provided
  -a {GRCh37,GRCh38}, --assembly {GRCh37,GRCh38}
                        Genome assembly of input, either GRCh38 or GRCh37
  -l /path/to/liftover, --liftover /path/to/liftover
                        Liftover executable path, required if assembly is
                        GRCh37
```

