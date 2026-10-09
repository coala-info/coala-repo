# igfinder CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| igfinder | PASS | fixed baseCommand (igfinder, not igfinder.py) and output glob; 1000 real airrflow BCR reads with an IGHJ anchor table built from IMGT gave 110 selected reads whose protein ends in WGQG...VSS |

## igfinder

### Tool Description
ver 1.0 filtering fasta file for Ig analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/igfinder:1.0--pyhdfd78af_0
- **Homepage**: https://tx.bioreg.kyushu-u.ac.jp/igfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/igfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igfinder/overview
- **Total Downloads**: 973
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: igfinder.py [-h] -i I [-o O] [-c C] -r R

igfinder ver 1.0 filtering fasta file for Ig analysis

optional arguments:
  -h, --help  show this help message and exit
  -i I        input_filename(fasta_format)
  -o O        output_dir
  -c C        Analysis frame: default=starts from M
  -r R        sequence_reference csv file
```

