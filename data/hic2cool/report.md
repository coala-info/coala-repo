# hic2cool CWL Generation Report

## hic2cool_convert

### Tool Description
convert a hic file to a cooler file

### Metadata
- **Docker Image**: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/4dn-dcic/hic2cool
- **Package**: https://anaconda.org/channels/bioconda/packages/hic2cool/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hic2cool/overview
- **Total Downloads**: 53.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/4dn-dcic/hic2cool
- **Stars**: N/A
### Original Help Text
```text
usage: hic2cool convert [-h] [-r RESOLUTION] [-p NPROC] [-s] [-w]
                        infile outfile

convert a hic file to a cooler file

positional arguments:
  infile                hic input file path
  outfile               cooler output file path

options:
  -h, --help            show this help message and exit
  -r RESOLUTION, --resolution RESOLUTION
                        integer bp resolution desired in cooler file. Setting
                        to 0 (default) will use all resolutions. If all
                        resolutions are used, a multi-res .cool file will be
                        created, which has a different hdf5 structure. See the
                        README for more info
  -p NPROC, --nproc NPROC
                        number of processes to use to parse hic file. default
                        set to 1
  -s, --silent          if used, silence standard program output
  -w, --warnings        if used, print out non-critical WARNING messages,
                        which are hidden by default. Silent mode takes
                        precedence over this
```


## hic2cool_update

### Tool Description
update a cooler file produced by hic2cool

### Metadata
- **Docker Image**: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/4dn-dcic/hic2cool
- **Package**: https://anaconda.org/channels/bioconda/packages/hic2cool/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hic2cool update [-h] [-o OUTFILE] [-s] [-w] infile

update a cooler file produced by hic2cool

positional arguments:
  infile                cooler input file path

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        optional new output file path
  -s, --silent          if used, silence standard program output
  -w, --warnings        if used, print out non-critical WARNING messages,
                        which are hidden by default. Silent mode takes
                        precedence over this
```


## hic2cool_extract-norms

### Tool Description
extract normalization vectors from a cooler file and add them to a cooler file

### Metadata
- **Docker Image**: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/4dn-dcic/hic2cool
- **Package**: https://anaconda.org/channels/bioconda/packages/hic2cool/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hic2cool extract-norms [-h] [-e] [-s] [-w] infile outfile

extract normalization vectors from a cooler file and add them to a cooler file

positional arguments:
  infile            hic file path
  outfile           cooler file path

options:
  -h, --help        show this help message and exit
  -e, --exclude-mt  if used, exclude the mitochondria (MT) from the output
  -s, --silent      if used, silence standard program output
  -w, --warnings    if used, print out non-critical WARNING messages, which
                    are hidden by default. Silent mode takes precedence over
                    this
```


## Metadata
- **Skill**: generated
