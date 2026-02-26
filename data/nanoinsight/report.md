# nanoinsight CWL Generation Report

## nanoinsight

### Tool Description
NanoINSight is a repeat annotation tool for insertions called by NanoVar

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoinsight:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoinsight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanoinsight/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight
- **Stars**: N/A
### Original Help Text
```text
usage: nanoinsight [options] -s [species] [VCF] [work_directory]

NanoINSight is a repeat annotation tool for insertions called by NanoVar

required arguments:
  -s str, --species str
                        specify species for repeatmasker (e.g. human)
  [VCF]                 path to input VCF file
  [work_directory]      path to work directory

optional arguments:
  -h, --help            show this help message and exit
  -i path, --insfa path
                        specify path to ins_seq.fa file from NanoVar, 
                        otherwise assumed in work directory
  -u path, --suptsv path
                        specify path to sv_support_reads.tsv file from NanoVar, 
                        otherwise assumed in work directory
  -m path, --mafftpath path
                        specify path to 'mafft' executable
  -r path, --repmaskpath path
                        specify path to 'RepeatMasker' executable
  -t int, --threads int
                        specify number of threads [1]
  -v, --version         print version
  -q, --quiet           hide verbose
```

