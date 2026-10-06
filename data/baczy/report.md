# baczy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| baczy_citation | Failed | not a usable tool: it only prints a citation, the baseCommand is the CWL file name, and its inputs are DOI lines from the help. |
| baczy_config | PASS |  |
| baczy_run | Not completed | the Snakemake pipeline needs Bakta and GTDB-Tk databases plus per-rule Singularity or conda environments with network access; fastp, megahit and bakta are not in the image. |

## baczy_run

### Tool Description
Run baczy

### Metadata
- **Docker Image**: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/npbhavya/baczy/
- **Package**: https://anaconda.org/channels/bioconda/packages/baczy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/baczy/overview
- **Total Downloads**: 145
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/npbhavya/baczy
- **Stars**: N/A
### Original Help Text
```text
Usage: baczy run [OPTIONS] [SNAKE_ARGS]...

  Run baczy

Options:
  --input TEXT                    Input file/directory  [required]
  --sequencing [paired|longread]  sequencing method  [default: paired]
  --output PATH                   Output directory  [default: baczy.out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/config.yaml]
  --threads INTEGER               Number of threads to use  [default: 1]
  --profile TEXT                  Snakemake profile to use
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default: no-
                                  use-conda]
  --use-singularity / --no-use-singularity
                                  Use containers for Snakemake rules
                                  [default: use-singularity]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --printshellcmds, --nolock, --show-failed-
                                  logs]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  baczy run ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
```


## baczy_config

### Tool Description
Copy the system default config file

### Metadata
- **Docker Image**: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/npbhavya/baczy/
- **Package**: https://anaconda.org/channels/bioconda/packages/baczy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baczy config [OPTIONS]

  Copy the system default config file

Options:
  --configfile TEXT  Copy template config to file  [default: config.yaml]
  -h, --help         Show this message and exit.
```


## baczy_citation

### Tool Description
Please cite sphaehost in your paper using this article:

### Metadata
- **Docker Image**: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/npbhavya/baczy/
- **Package**: https://anaconda.org/channels/bioconda/packages/baczy/overview
- **Validation**: PASS

### Original Help Text
```text
Please cite sphaehost in your paper using this article:


Please consider also citing these dependencies:
Snaketool:
https://doi.org/10.1371/journal.pcbi.1010705

Snakemake:
https://doi.org/10.12688/f1000research.29032.1
```


## Metadata
- **Skill**: generated
