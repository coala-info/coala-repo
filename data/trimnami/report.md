# trimnami CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trimnami_config | PASS | wrote the default config file and profile |
| trimnami_run | Not completed | pipeline, skipped |
| trimnami_testnp | Not completed | pipeline, skipped |

## trimnami_run

### Tool Description
Run Trimnami

### Metadata
- **Docker Image**: quay.io/biocontainers/trimnami:0.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/beardymcjohnface/Trimnami
- **Package**: https://anaconda.org/channels/bioconda/packages/trimnami/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trimnami/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/beardymcjohnface/Trimnami
- **Stars**: N/A
### Original Help Text
```text

████████╗██████╗ ██╗███╗   ███╗███╗   ██╗ █████╗ ███╗   ███╗██╗
╚══██╔══╝██╔══██╗██║████╗ ████║████╗  ██║██╔══██╗████╗ ████║██║
   ██║   ██████╔╝██║██╔████╔██║██╔██╗ ██║███████║██╔████╔██║██║
   ██║   ██╔══██╗██║██║╚██╔╝██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║
   ██║   ██║  ██║██║██║ ╚═╝ ██║██║ ╚████║██║  ██║██║ ╚═╝ ██║██║
   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝

Usage: trimnami run [OPTIONS] [SNAKE_ARGS]...

  Run Trimnami

Options:
  --host TEXT                     Host genome fasta for filtering
  --minimap [sr|map-pb|map-ont|map-hifi]
                                  Minimap preset  [default: sr]
  --fastqc / --no-fastqc          Run fastqc on trimmed and untrimmed reads
                                  [default: no-fastqc]
  --fasta / --no-fasta            Output fasta format files instead of fastq
                                  [default: no-fasta]
  --subsample / --no-subsample    Perform subsampling (set in config file)
  --output PATH                   Output directory  [default: trimnami.out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/trimnami.config.yaml]
  --threads INTEGER               Number of threads to use  [default: 8]
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --workflow-profile TEXT         Custom config file [default:
                                  (outputDir)/trimnami.profile/]
  --reads TEXT                    Input file/directory  [required]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  trimnami run ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           trimnami run --reads [file]
  Specify threads:    trimnami run ... --threads [threads]
  Disable conda:      trimnami run ... --no-use-conda 
  Change defaults:    trimnami run ... --snake-default="-k --nolock"
  Add Snakemake args: trimnami run ... --dry-run --keep-going --touch
  Specify targets:    trimnami run ... all print_targets
  Available targets:
      fastp           Trim reads with fastp (default)
      prinseq         Trim reads with prinseq++
      roundAB         Trim round A/B viral metagenome reads
      cutadapt        Trim with cutadapt (support for FASTA input)
      filtlong        Filter out short-length longreads
      notrim          Skip read trimming
      print_trimmers  List available trimming modules
```

## trimnami_testnp

### Tool Description
Test Trimnami with the test LR dataset and test host

### Metadata
- **Docker Image**: quay.io/biocontainers/trimnami:0.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/beardymcjohnface/Trimnami
- **Package**: https://anaconda.org/channels/bioconda/packages/trimnami/overview
- **Validation**: PASS

### Original Help Text
```text

████████╗██████╗ ██╗███╗   ███╗███╗   ██╗ █████╗ ███╗   ███╗██╗
╚══██╔══╝██╔══██╗██║████╗ ████║████╗  ██║██╔══██╗████╗ ████║██║
   ██║   ██████╔╝██║██╔████╔██║██╔██╗ ██║███████║██╔████╔██║██║
   ██║   ██╔══██╗██║██║╚██╔╝██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║
   ██║   ██║  ██║██║██║ ╚═╝ ██║██║ ╚████║██║  ██║██║ ╚═╝ ██║██║
   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝

Usage: trimnami testnp [OPTIONS] [SNAKE_ARGS]...

  Test Trimnami with the test LR dataset and test host

Options:
  --host TEXT                     Host genome fasta for filtering
  --minimap [sr|map-pb|map-ont|map-hifi]
                                  Minimap preset  [default: sr]
  --fastqc / --no-fastqc          Run fastqc on trimmed and untrimmed reads
                                  [default: no-fastqc]
  --fasta / --no-fasta            Output fasta format files instead of fastq
                                  [default: no-fasta]
  --subsample / --no-subsample    Perform subsampling (set in config file)
  --output PATH                   Output directory  [default: trimnami.out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/trimnami.config.yaml]
  --threads INTEGER               Number of threads to use  [default: 8]
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --workflow-profile TEXT         Custom config file [default:
                                  (outputDir)/trimnami.profile/]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  trimnami run ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           trimnami run --reads [file]
  Specify threads:    trimnami run ... --threads [threads]
  Disable conda:      trimnami run ... --no-use-conda 
  Change defaults:    trimnami run ... --snake-default="-k --nolock"
  Add Snakemake args: trimnami run ... --dry-run --keep-going --touch
  Specify targets:    trimnami run ... all print_targets
  Available targets:
      fastp           Trim reads with fastp (default)
      prinseq         Trim reads with prinseq++
      roundAB         Trim round A/B viral metagenome reads
      cutadapt        Trim with cutadapt (support for FASTA input)
      filtlong        Filter out short-length longreads
      notrim          Skip read trimming
      print_trimmers  List available trimming modules
```

## trimnami_config

### Tool Description
Copy the system default config file

### Metadata
- **Docker Image**: quay.io/biocontainers/trimnami:0.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/beardymcjohnface/Trimnami
- **Package**: https://anaconda.org/channels/bioconda/packages/trimnami/overview
- **Validation**: PASS

### Original Help Text
```text

████████╗██████╗ ██╗███╗   ███╗███╗   ██╗ █████╗ ███╗   ███╗██╗
╚══██╔══╝██╔══██╗██║████╗ ████║████╗  ██║██╔══██╗████╗ ████║██║
   ██║   ██████╔╝██║██╔████╔██║██╔██╗ ██║███████║██╔████╔██║██║
   ██║   ██╔══██╗██║██║╚██╔╝██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║
   ██║   ██║  ██║██║██║ ╚═╝ ██║██║ ╚████║██║  ██║██║ ╚═╝ ██║██║
   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝

Usage: trimnami config [OPTIONS] [SNAKE_ARGS]...

  Copy the system default config file

Options:
  --output PATH                 Output directory  [default: trimnami.out]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/trimnami.config.yaml]
  --threads INTEGER             Number of threads to use  [default: 8]
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: use-
                                conda]
  --conda-prefix PATH           Custom conda env directory
  --workflow-profile TEXT       Custom config file [default:
                                (outputDir)/trimnami.profile/]
  -h, --help                    Show this message and exit.
```

## Metadata
- **Skill**: generated
