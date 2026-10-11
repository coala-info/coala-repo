# negspy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| negspy_chr_pos_to_genome_pos | Failed | image problem: numpy is missing in the image (ModuleNotFoundError) |
| negspy_create_chrominfo | Failed | image problem: Bio (biopython) is missing in the image (ModuleNotFoundError) |
| negspy_make_triangular | PASS | synthetic data: small planted coordinate table |

## negspy_chr_pos_to_genome_pos

### Tool Description
Convert chromosome,position pairs to genome positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
- **Homepage**: https://github.com/pkerpedjiev/negspy
- **Package**: https://anaconda.org/channels/bioconda/packages/negspy/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/chr_pos_to_genome_pos.py", line 4, in <module>
    import negspy.coordinates as nc
  File "/usr/local/lib/python3.14/site-packages/negspy/coordinates.py", line 4, in <module>
    import numpy as np
ModuleNotFoundError: No module named 'numpy'
```

## negspy_create_chrominfo

### Tool Description
Create a chromInfo file for a genome FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
- **Homepage**: https://github.com/pkerpedjiev/negspy
- **Package**: https://anaconda.org/channels/bioconda/packages/negspy/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/create_chrominfo.py", line 3, in <module>
    import Bio.SeqIO as bsio
ModuleNotFoundError: No module named 'Bio'
```

## negspy_make_triangular

### Tool Description
Sort the first two coordinate columns so they are triangular.

### Metadata
- **Docker Image**: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
- **Homepage**: https://github.com/pkerpedjiev/negspy
- **Package**: https://anaconda.org/channels/bioconda/packages/negspy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: make_triangular.py [-h]

python make_triangular.py Make sure that the coordinates passed in are
triangular. Sorts the first two columns so that the resulting coordinates are
triangular.

options:
  -h, --help  show this help message and exit
```

