# ptools_bin CWL Generation Report

## ptools_bin_pbam2bam

### Tool Description
A tool for converting pBAM files to BAM files, supporting different modes such as genome-based conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ENCODE-DCC/ptools_bin
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pbam2bam", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/ptools_bin/pbam2bam.py", line 17, in main
    if sys.argv[1] == "genome":
IndexError: list index out of range
```


## ptools_bin_pbam_mapped_transcriptome

### Tool Description
A tool to process mapped transcriptome data. Based on the source code, it requires at least one input file as a positional argument.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
- **Homepage**: https://github.com/ENCODE-DCC/ptools_bin
- **Package**: https://anaconda.org/channels/bioconda/packages/ptools_bin/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pbam_mapped_transcriptome", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/ptools_bin/pbam_mapped_transcriptome.py", line 53, in main
    with open(sys.argv[1], "rt") as f1:
IndexError: list index out of range
```

