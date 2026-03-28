# nextclade_js CWL Generation Report

## nextclade_js_nextclade

### Tool Description
Viral genome alignment, mutation calling, clade assignment, quality checks and phylogenetic placement.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
- **Homepage**: https://github.com/nextstrain/nextclade
- **Package**: https://anaconda.org/channels/bioconda/packages/nextclade_js/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nextclade_js/overview
- **Total Downloads**: 10.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nextstrain/nextclade
- **Stars**: N/A
### Original Help Text
```text
Viral genome alignment, mutation calling, clade assignment, quality checks and phylogenetic placement.

Nextclade is a part of Nextstrain: https://nextstrain.org

Documentation: https://docs.nextstrain.org/projects/nextclade
Nextclade Web: https://clades.nextstrain.org
Publication:   https://doi.org/10.21105/joss.03773

For short help type: `nextclade -h`, for extended help type: `nextclade --help`. Each subcommand has its own help, for example: `nextclade run --help`.

Usage: nextclade [OPTIONS] <COMMAND>

Commands:
  completions      Generate shell completions
  run              Run sequence analysis: alignment, mutation calling, clade assignment, quality checks and phylogenetic placement
  dataset          List and download available Nextclade datasets (pathogens)
  sort             Sort sequences according to the inferred Nextclade dataset (pathogen)
  read-annotation  Read genome annotation and present it in Nextclade's internal formats. This is mostly only useful for Nextclade maintainers and the most curious users. Note that these internal formats have no stability guarantees and can be changed at any time without notice
  schema           Write JSON schema definitions for Nextclade file formats
  help-markdown    Print command-line reference documentation in Markdown format
  help             Print this message or the help of the given subcommand(s)

Options:
  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version

Verbosity:
      --verbosity <VERBOSITY>
          Set verbosity level of console output
          
          [default: warn]
          [possible values: off, error, warn, info, debug, trace]

      --silent
          Disable all console output. Same as `--verbosity=off`

  -v, --verbose...
          Make console output more verbose. Add multiple occurrences to increase verbosity further

  -q, --quiet...
          Make console output more quiet. Add multiple occurrences to make output even more quiet

      --color <COLOR>
          Control when to use colored output [env: COLOR, NO_COLOR, CLICOLOR_FORCE]
          
          Color output control follows this precedence (highest to lowest):
          
          1. Command-line flags:
          
          - `--color`
          
          - `--no-color`
          
          2. Environment variables:
          
          - `CLICOLOR_FORCE=1` - force color
          
          - `NO_COLOR` (set) - disable color
          
          - `COLOR=always|auto|never`
          
          If both `--color` and `--no-color` are provided, the one specified last takes effect.

          Possible values:
          - auto:   Automatically enable colors if output is a TTY (default)
          - always: Always enable colors
          - never:  Never enable colors

      --no-color
          Disable colored output (shorthand for --color=never)
          
          This overrides all related color environment variables (`CLICOLOR_FORCE`, `NO_COLOR`, `COLOR`)
          
          If both `--color` and `--no-color` are provided, the one specified last takes effect.
```


## nextclade_js_nextclade dataset

### Tool Description
List and download available Nextclade datasets (pathogens)

### Metadata
- **Docker Image**: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
- **Homepage**: https://github.com/nextstrain/nextclade
- **Package**: https://anaconda.org/channels/bioconda/packages/nextclade_js/overview
- **Validation**: PASS

### Original Help Text
```text
List and download available Nextclade datasets (pathogens)

For short help type: `nextclade -h`, for extended help type: `nextclade --help`. Each subcommand has its own help, for example: `nextclade dataset --help`.

Usage: nextclade dataset [OPTIONS] <COMMAND>

Commands:
  list  List available Nextclade datasets
  get   Download available Nextclade datasets
  help  Print this message or the help of the given subcommand(s)

Options:
  -h, --help
          Print help (see a summary with '-h')

Verbosity:
      --verbosity <VERBOSITY>
          Set verbosity level of console output
          
          [default: warn]
          [possible values: off, error, warn, info, debug, trace]

      --silent
          Disable all console output. Same as `--verbosity=off`

  -v, --verbose...
          Make console output more verbose. Add multiple occurrences to increase verbosity further

  -q, --quiet...
          Make console output more quiet. Add multiple occurrences to make output even more quiet

      --color <COLOR>
          Control when to use colored output [env: COLOR, NO_COLOR, CLICOLOR_FORCE]
          
          Color output control follows this precedence (highest to lowest):
          
          1. Command-line flags:
          
          - `--color`
          
          - `--no-color`
          
          2. Environment variables:
          
          - `CLICOLOR_FORCE=1` - force color
          
          - `NO_COLOR` (set) - disable color
          
          - `COLOR=always|auto|never`
          
          If both `--color` and `--no-color` are provided, the one specified last takes effect.

          Possible values:
          - auto:   Automatically enable colors if output is a TTY (default)
          - always: Always enable colors
          - never:  Never enable colors

      --no-color
          Disable colored output (shorthand for --color=never)
          
          This overrides all related color environment variables (`CLICOLOR_FORCE`, `NO_COLOR`, `COLOR`)
          
          If both `--color` and `--no-color` are provided, the one specified last takes effect.
```


## Metadata
- **Skill**: generated
