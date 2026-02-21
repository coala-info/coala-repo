# pbipa CWL Generation Report

## pbipa

### Tool Description
FAIL to generate CWL: pbipa not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbipa:1.8.0--h1104d80_3
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbipa/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbipa/overview
- **Total Downloads**: 38.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbbioconda
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pbipa not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pbipa not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pbipa_ipa

### Tool Description
Improved Phased Assembly tool for HiFi reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbipa:1.8.0--h1104d80_3
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/pbipa/overview
- **Validation**: PASS
### Original Help Text
```text
usage: ipa [-h] [--version] {local,dist,validate} ...

Improved Phased Assembly tool for HiFi reads.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

subcommands:
  One of these must follow the options listed above and may be followed by sub-command specific options.

  {local,dist,validate}
                        sub-command help
    local               Run IPA on your local machine.
    dist                Distribute IPA jobs to your cluster.
    validate            Check dependencies.

Try "ipa local --help".
Or "ipa validate" to validate dependencies.
https://github.com/PacificBiosciences/pbbioconda/wiki/Improved-Phased-Assember
```

