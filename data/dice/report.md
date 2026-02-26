# dice CWL Generation Report

## dice

### Tool Description
A tool for phylogenetic reconstruction.

### Metadata
- **Docker Image**: quay.io/biocontainers/dice:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/samsonweiner/DICE
- **Package**: https://anaconda.org/channels/bioconda/packages/dice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dice/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/samsonweiner/DICE
- **Stars**: N/A
### Original Help Text
```text
usage: dice [-h] -i INPUT [-o OUTPUT] [-p PREFIX] [-s] [-b] [-t]
            [-d DIST_TYPE] [-m REC_METHOD] [-n] [-f FASTME_PATH] [-z SEED]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to dataset.
  -o OUTPUT, --output OUTPUT
                        Output directory. Will create one if it does not
                        exist. Default is current directory.
  -p PREFIX, --prefix PREFIX
                        Prefix to add to output files.
  -s, --save-dm         Toggle to save the distance matrix to a file.
  -b, --breakpoint      Toggle to use breakpoint profiles.
  -t, --total-cn        Use total copy numbers instead of allele-specific copy
                        numbers.
  -d DIST_TYPE, --dist-type DIST_TYPE
                        Distance measure type. Options are 'root', 'log',
                        'manhattan', and 'euclidean'. Defaults to root.
  -m REC_METHOD, --rec-method REC_METHOD
                        Phylogenetic reconstruction algorithm. If not
                        specified, will compute the distance matrix and save
                        to a file. Options are 'NJ', 'uNJ', 'balME', and
                        'olsME'.
  -n, --use-NNI         For ME methods, toggle to use NNI tree search. By
                        default, SPR tree search is used.
  -f FASTME_PATH, --fastme-path FASTME_PATH
                        Path to 'fastme' executable. By default, assumes the
                        fastme executable is added to the user $PATH and is
                        called directly.
  -z SEED, --seed SEED  Randomization seed used in fastme.
```

