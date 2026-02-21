# architeuthis CWL Generation Report

## architeuthis_completion

### Tool Description
Generate the autocompletion script for the specified shell

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2026-01-30
- **GitHub**: https://github.com/cdiener/architeuthis
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis completion [command]

Available Commands:
  bash        Generate the autocompletion script for bash
  fish        Generate the autocompletion script for fish
  powershell  Generate the autocompletion script for powershell
  zsh         Generate the autocompletion script for zsh

Flags:
  -h, --help   help for completion

Global Flags:
      --db string   path to the Kraken database [optional]

Use "architeuthis completion [command] --help" for more information about a command.
```


## architeuthis_lineage

### Tool Description
A subcommand of the architeuthis tool (Note: The provided input was a runtime error/stack trace rather than help text, so specific arguments could not be extracted).

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
panic: runtime error: index out of range [0] with length 0

goroutine 1 [running]:
github.com/cdiener/architeuthis/cmd.init.func3(0x6456524ce4a0, {0x6456524f3760, 0x0, 0x6456522651e6?})
	github.com/cdiener/architeuthis/cmd/lineage.go:62 +0x36c
github.com/spf13/cobra.(*Command).execute(0x6456524ce4a0, {0x6456524f3760, 0x0, 0x0})
	github.com/spf13/cobra@v1.7.0/command.go:944 +0x871
github.com/spf13/cobra.(*Command).ExecuteC(0x6456524ced40)
	github.com/spf13/cobra@v1.7.0/command.go:1068 +0x398
github.com/spf13/cobra.(*Command).Execute(...)
	github.com/spf13/cobra@v1.7.0/command.go:992
github.com/cdiener/architeuthis/cmd.Execute()
	github.com/cdiener/architeuthis/cmd/root.go:42 +0x1a
main.main()
	github.com/cdiener/architeuthis/main.go:29 +0x10c
```


## architeuthis_mapping

### Tool Description
A tool for processing Kraken output, including filtering, k-mer summarization, and scoring.

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis mapping [command]

Available Commands:
  filter      Filter Kraken output based on read quality.
  kmers       Summarize k-mer assignments for classified taxa.
  score       Scores and evaluates reads.
  summary     Summarize k-mer assignments for classified taxa on taxonomic ranks.

Flags:
  -h, --help   help for mapping

Global Flags:
      --db string   path to the Kraken database [optional]

Use "architeuthis mapping [command] --help" for more information about a command.
```


## architeuthis_merge

### Tool Description
Merge results using architeuthis

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis merge [flags]

Flags:
  -h, --help         help for merge
  -o, --out string   The output filename. (default "merged.csv")

Global Flags:
      --db string   path to the Kraken database [optional]
```


## Metadata
- **Skill**: generated
