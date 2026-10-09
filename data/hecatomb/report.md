# hecatomb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hecatomb_add-host | Not completed | pipeline, skipped |
| hecatomb_combine | Not completed | pipeline, skipped |
| hecatomb_config | PASS |  |
| hecatomb_list-hosts | Not completed | lists installed host genomes; none are installed without the large hecatomb install database download, so the output is empty |
| hecatomb_run | Not completed | pipeline, skipped |

## hecatomb_run

### Tool Description
Run hecatomb

### Metadata
- **Docker Image**: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
- **Homepage**: https://github.com/shandley/hecatomb
- **Package**: https://anaconda.org/channels/bioconda/packages/hecatomb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hecatomb/overview
- **Total Downloads**: 20.9K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/shandley/hecatomb
- **Stars**: N/A
### Original Help Text
```text

██╗  ██╗███████╗ ██████╗ █████╗ ████████╗ ██████╗ ███╗   ███╗██████╗
██║  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗
███████║█████╗  ██║     ███████║   ██║   ██║   ██║██╔████╔██║██████╔╝
██╔══██║██╔══╝  ██║     ██╔══██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██╗
██║  ██║███████╗╚██████╗██║  ██║   ██║   ╚██████╔╝██║ ╚═╝ ██║██████╔╝
╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═════╝

Usage: hecatomb run [OPTIONS] [SNAKE_ARGS]...

  Run hecatomb

Options:
  --reads TEXT                    Input file/directory  [required]
  --trim [fastp|prinseq|roundAB|filtlong|notrim|cutadapt]
                                  Trimming engine for trimnami  [default:
                                  fastp]
  --fastqc / --no-fastqc          Generate fastqc reports  [default: no-
                                  fastqc]
  --longreads / --no-longreads    Sequencing is longreads (PacBio, Nanopore,
                                  etc)  [default: no-longreads]
  --assembly [cross|merged]       Assembly method: [cross]-assembly or
                                  [merged]-assembly  [default: merged]
  --custom-aa PATH                Custom protein fasta for prefiltering
  --custom-nt PATH                Custom nucleotide fasta for prefiltering
  --search [fast|sensitive]       MMSeqs search speed settings  [default:
                                  sensitive]
  --host TEXT                     Host genome name for filtering, or 'none'
                                  for no host removal.  [default: human]
  --output PATH                   Output directory  [default: hecatomb.out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/hecatomb.config.yaml]
  --threads INTEGER               Number of threads to use  [default: 32]
  --profile TEXT                  Snakemake profile
  --workflow-profile TEXT         Custom config file [default:
                                  (outputDir)/hecatomb.profile/]
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default: no-
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  hecatomb run ... --profile [profile]
  
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hecatomb run --reads [file/dir]
  Specify threads:    hecatomb run ... --threads [threads]
  Disable conda:      hecatomb run ... --no-use-conda 
  Change defaults:    hecatomb run ... --snake-default="-k --nolock"
  Add Snakemake args: hecatomb run ... --dry-run --keep-going --touch
  Specify stages:     hecatomb run ... all print_stages
  
  AVAILABLE STAGES:
      all                 Run everything (default)
      preprocessing       Preprocessing steps only
      assembly            Assembly steps (+ preprocess)
      read_annotations    Read annotations (+ preprocess)
      contig_annotations  Contig annotations (+ preprocess,assemble)
      print_stages        List available stages
```

## hecatomb_config

### Tool Description
Copy the system default config file

### Metadata
- **Docker Image**: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
- **Homepage**: https://github.com/shandley/hecatomb
- **Package**: https://anaconda.org/channels/bioconda/packages/hecatomb/overview
- **Validation**: PASS

### Original Help Text
```text

██╗  ██╗███████╗ ██████╗ █████╗ ████████╗ ██████╗ ███╗   ███╗██████╗
██║  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗
███████║█████╗  ██║     ███████║   ██║   ██║   ██║██╔████╔██║██████╔╝
██╔══██║██╔══╝  ██║     ██╔══██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██╗
██║  ██║███████╗╚██████╗██║  ██║   ██║   ╚██████╔╝██║ ╚═╝ ██║██████╔╝
╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═════╝

Usage: hecatomb config [OPTIONS] [SNAKE_ARGS]...

  Copy the system default config file

Options:
  --output PATH                 Output directory  [default: hecatomb.out]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/hecatomb.config.yaml]
  --threads INTEGER             Number of threads to use  [default: 32]
  --profile TEXT                Snakemake profile
  --workflow-profile TEXT       Custom config file [default:
                                (outputDir)/hecatomb.profile/]
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: no-
                                use-conda]
  --conda-prefix PATH           Custom conda env directory
  -h, --help                    Show this message and exit.
```

## hecatomb_combine

### Tool Description
Combine multiple Hecatomb runs

### Metadata
- **Docker Image**: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
- **Homepage**: https://github.com/shandley/hecatomb
- **Package**: https://anaconda.org/channels/bioconda/packages/hecatomb/overview
- **Validation**: PASS

### Original Help Text
```text

██╗  ██╗███████╗ ██████╗ █████╗ ████████╗ ██████╗ ███╗   ███╗██████╗
██║  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗
███████║█████╗  ██║     ███████║   ██║   ██║   ██║██╔████╔██║██████╔╝
██╔══██║██╔══╝  ██║     ██╔══██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██╗
██║  ██║███████╗╚██████╗██║  ██║   ██║   ╚██████╔╝██║ ╚═╝ ██║██████╔╝
╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═════╝

Usage: hecatomb combine [OPTIONS] [SNAKE_ARGS]...

  Combine multiple Hecatomb runs

Options:
  --comb TEXT                   Two or more Hecatomb output directories to
                                combine. e.g. --comb dir1/ --comb dir2/ ...
                                [required]
  --output PATH                 Output directory  [default: hecatomb.out]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/hecatomb.config.yaml]
  --threads INTEGER             Number of threads to use  [default: 32]
  --profile TEXT                Snakemake profile
  --workflow-profile TEXT       Custom config file [default:
                                (outputDir)/hecatomb.profile/]
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: no-
                                use-conda]
  --conda-prefix PATH           Custom conda env directory
  -h, --help                    Show this message and exit.

  CLUSTER EXECUTION:
  hecatomb run ... --profile [profile]
  
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hecatomb run --reads [file/dir]
  Specify threads:    hecatomb run ... --threads [threads]
  Disable conda:      hecatomb run ... --no-use-conda 
  Change defaults:    hecatomb run ... --snake-default="-k --nolock"
  Add Snakemake args: hecatomb run ... --dry-run --keep-going --touch
  Specify stages:     hecatomb run ... all print_stages
  
  AVAILABLE STAGES:
      all                 Run everything (default)
      preprocessing       Preprocessing steps only
      assembly            Assembly steps (+ preprocess)
      read_annotations    Read annotations (+ preprocess)
      contig_annotations  Contig annotations (+ preprocess,assemble)
      print_stages        List available stages
```

## hecatomb_add-host

### Tool Description
Add a new host genome to use with Hecatomb

### Metadata
- **Docker Image**: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
- **Homepage**: https://github.com/shandley/hecatomb
- **Package**: https://anaconda.org/channels/bioconda/packages/hecatomb/overview
- **Validation**: PASS

### Original Help Text
```text

██╗  ██╗███████╗ ██████╗ █████╗ ████████╗ ██████╗ ███╗   ███╗██████╗
██║  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗
███████║█████╗  ██║     ███████║   ██║   ██║   ██║██╔████╔██║██████╔╝
██╔══██║██╔══╝  ██║     ██╔══██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██╗
██║  ██║███████╗╚██████╗██║  ██║   ██║   ╚██████╔╝██║ ╚═╝ ██║██████╔╝
╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═════╝

Usage: hecatomb add-host [OPTIONS] [SNAKE_ARGS]...

  Add a new host genome to use with Hecatomb

Options:
  --host TEXT                   Name for your host genome  [required]
  --host-fa TEXT                Host genome fasta file  [required]
  --output PATH                 Output directory  [default: hecatomb.out]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/hecatomb.config.yaml]
  --threads INTEGER             Number of threads to use  [default: 32]
  --profile TEXT                Snakemake profile
  --workflow-profile TEXT       Custom config file [default:
                                (outputDir)/hecatomb.profile/]
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: no-
                                use-conda]
  --conda-prefix PATH           Custom conda env directory
  -h, --help                    Show this message and exit.

  CLUSTER EXECUTION:
  hecatomb run ... --profile [profile]
  
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hecatomb run --reads [file/dir]
  Specify threads:    hecatomb run ... --threads [threads]
  Disable conda:      hecatomb run ... --no-use-conda 
  Change defaults:    hecatomb run ... --snake-default="-k --nolock"
  Add Snakemake args: hecatomb run ... --dry-run --keep-going --touch
  Specify stages:     hecatomb run ... all print_stages
  
  AVAILABLE STAGES:
      all                 Run everything (default)
      preprocessing       Preprocessing steps only
      assembly            Assembly steps (+ preprocess)
      read_annotations    Read annotations (+ preprocess)
      contig_annotations  Contig annotations (+ preprocess,assemble)
      print_stages        List available stages
```

## hecatomb_list-hosts

### Tool Description
List the available host genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
- **Homepage**: https://github.com/shandley/hecatomb
- **Package**: https://anaconda.org/channels/bioconda/packages/hecatomb/overview
- **Validation**: PASS

### Original Help Text
```text

██╗  ██╗███████╗ ██████╗ █████╗ ████████╗ ██████╗ ███╗   ███╗██████╗
██║  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗
███████║█████╗  ██║     ███████║   ██║   ██║   ██║██╔████╔██║██████╔╝
██╔══██║██╔══╝  ██║     ██╔══██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██╗
██║  ██║███████╗╚██████╗██║  ██║   ██║   ╚██████╔╝██║ ╚═╝ ██║██████╔╝
╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═════╝

Usage: hecatomb list-hosts [OPTIONS] [SNAKE_ARGS]...

  List the available host genomes

Options:
  --output PATH                 Output directory  [default: hecatomb.out]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/hecatomb.config.yaml]
  --threads INTEGER             Number of threads to use  [default: 32]
  --profile TEXT                Snakemake profile
  --workflow-profile TEXT       Custom config file [default:
                                (outputDir)/hecatomb.profile/]
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: no-
                                use-conda]
  --conda-prefix PATH           Custom conda env directory
  -h, --help                    Show this message and exit.
```

## Metadata
- **Skill**: generated
