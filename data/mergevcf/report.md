# mergevcf CWL Generation Report

## mergevcf

### Tool Description
Merge calls in VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/mergevcf:1.0.1--py27_0
- **Homepage**: https://github.com/ljdursi/mergevcf
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mergevcf/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ljdursi/mergevcf
- **Stars**: N/A
### Original Help Text
```text
usage: mergevcf [-h] [-o OUTPUT] [-v] [-l LABELS] [-n] [-m MINCALLERS] [-s]
                [-f] [-w SVWINDOW]
                input_files [input_files ...]

Merge calls in VCF files

positional arguments:
  input_files           Input VCF files

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Specify output file (default:stdout)
  -v, --verbose         Specify verbose output
  -l LABELS, --labels LABELS
                        Comma-separated labels for each input VCF file
                        (default:basenames)
  -n, --ncallers        Annotate variant with number of callers
  -m MINCALLERS, --mincallers MINCALLERS
                        Minimum # of callers for variant to pass
  -s, --sv              Force interpretation as SV (default:false)
  -f, --filtered        Include records that have failed one or more filters
                        (default:false)
  -w SVWINDOW, --svwindow SVWINDOW
                        Window for comparing breakpoint positions for SVs
                        (default:100)
```

