# primers CWL Generation Report

## primers_score

### Tool Description
Score primers based on amplification and off-target binding.

### Metadata
- **Docker Image**: quay.io/biocontainers/primers:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/Lattice-Automation/primers
- **Package**: https://anaconda.org/channels/bioconda/packages/primers/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/primers/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Lattice-Automation/primers
- **Stars**: N/A
### Original Help Text
```text
usage: primers score [-h] [-s SEQ] [-t SEQ] [-j | --json | --no-json]
                     primer [primer ...]

positional arguments:
  primer                primer sequences

options:
  -h, --help            show this help message and exit
  -s SEQ                the sequence that was amplified
  -t SEQ                sequence to check for off-target binding sites
  -j, --json, --no-json
                        write the primers to a JSON array
```


## primers_create

### Tool Description
create primers to amplify this sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/primers:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/Lattice-Automation/primers
- **Package**: https://anaconda.org/channels/bioconda/packages/primers/overview
- **Validation**: PASS

### Original Help Text
```text
usage: primers create [-h] [-f SEQ] [-fl INT INT] [-r SEQ] [-rl INT INT]
                      [-t SEQ] [-j | --json | --no-json]
                      SEQ

positional arguments:
  SEQ                   create primers to amplify this sequence

options:
  -h, --help            show this help message and exit
  -f SEQ                additional sequence to add to FWD primer (5' to 3')
  -fl INT INT           space separated min-max range for the length to add
                        from '-f' (5' to 3')
  -r SEQ                additional sequence to add to REV primer (5' to 3')
  -rl INT INT           space separated min-max range for the length to add
                        from '-r' (5' to 3')
  -t SEQ                sequence to check for off-target binding sites
  -j, --json, --no-json
                        write the primers to a JSON array
```

