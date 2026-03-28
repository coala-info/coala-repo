[ ]
[ ]

[Skip to content](#installation)

snakesee

Installation

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](index.html)
* [Snakesee Architecture](architecture.html)
* [ ]

  Installation

  [Installation](installation.html)

  Table of contents
  + [Requirements](#requirements)
  + [pip (recommended)](#pip-recommended)

    - [With logo support](#with-logo-support)
  + [conda / mamba](#conda-mamba)
  + [From source](#from-source)
  + [Verify installation](#verify-installation)
  + [Optional: Logger Plugin](#optional-logger-plugin)
* [Usage](usage.html)
* [ ]

  Reference

  Reference
  + [ ]

    [snakesee](reference/snakesee/index.html)

    snakesee
    - [cli](reference/snakesee/cli.html)
    - [constants](reference/snakesee/constants.html)
    - [ ]

      [estimation](reference/snakesee/estimation/index.html)

      estimation
      * [data\_loader](reference/snakesee/estimation/data_loader.html)
      * [estimator](reference/snakesee/estimation/estimator.html)
      * [pending\_inferrer](reference/snakesee/estimation/pending_inferrer.html)
      * [rule\_matcher](reference/snakesee/estimation/rule_matcher.html)
    - [estimator](reference/snakesee/estimator.html)
    - [events](reference/snakesee/events.html)
    - [exceptions](reference/snakesee/exceptions.html)
    - [formatting](reference/snakesee/formatting.html)
    - [log\_handler\_script](reference/snakesee/log_handler_script.html)
    - [logging](reference/snakesee/logging.html)
    - [models](reference/snakesee/models.html)
    - [parameter\_validation](reference/snakesee/parameter_validation.html)
    - [ ]

      [parser](reference/snakesee/parser/index.html)

      parser
      * [core](reference/snakesee/parser/core.html)
      * [failure\_tracker](reference/snakesee/parser/failure_tracker.html)
      * [file\_position](reference/snakesee/parser/file_position.html)
      * [job\_tracker](reference/snakesee/parser/job_tracker.html)
      * [line\_parser](reference/snakesee/parser/line_parser.html)
      * [log\_reader](reference/snakesee/parser/log_reader.html)
      * [metadata](reference/snakesee/parser/metadata.html)
      * [patterns](reference/snakesee/parser/patterns.html)
      * [stats](reference/snakesee/parser/stats.html)
      * [utils](reference/snakesee/parser/utils.html)
    - [ ]

      [plugins](reference/snakesee/plugins/index.html)

      plugins
      * [base](reference/snakesee/plugins/base.html)
      * [bwa](reference/snakesee/plugins/bwa.html)
      * [discovery](reference/snakesee/plugins/discovery.html)
      * [fastp](reference/snakesee/plugins/fastp.html)
      * [fgbio](reference/snakesee/plugins/fgbio.html)
      * [loader](reference/snakesee/plugins/loader.html)
      * [registry](reference/snakesee/plugins/registry.html)
      * [samtools](reference/snakesee/plugins/samtools.html)
      * [star](reference/snakesee/plugins/star.html)
    - [profile](reference/snakesee/profile.html)
    - [ ]

      [state](reference/snakesee/state/index.html)

      state
      * [clock](reference/snakesee/state/clock.html)
      * [config](reference/snakesee/state/config.html)
      * [job\_registry](reference/snakesee/state/job_registry.html)
      * [paths](reference/snakesee/state/paths.html)
      * [rule\_registry](reference/snakesee/state/rule_registry.html)
      * [workflow\_state](reference/snakesee/state/workflow_state.html)
    - [state\_comparison](reference/snakesee/state_comparison.html)
    - [ ]

      [tui](reference/snakesee/tui/index.html)

      tui
      * [monitor](reference/snakesee/tui/monitor.html)
    - [types](reference/snakesee/types.html)
    - [utils](reference/snakesee/utils.html)
    - [validation](reference/snakesee/validation.html)
    - [variance](reference/snakesee/variance.html)

Table of contents

* [Requirements](#requirements)
* [pip (recommended)](#pip-recommended)

  + [With logo support](#with-logo-support)
* [conda / mamba](#conda-mamba)
* [From source](#from-source)
* [Verify installation](#verify-installation)
* [Optional: Logger Plugin](#optional-logger-plugin)

# Installation[¶](#installation "Permanent link")

## Requirements[¶](#requirements "Permanent link")

* Python 3.11 or later
* A terminal that supports ANSI escape codes

## pip (recommended)[¶](#pip-recommended "Permanent link")

Install from PyPI:

```
pip install snakesee
```

### With logo support[¶](#with-logo-support "Permanent link")

To enable the Fulcrum Genomics logo easter egg (press `fg` in the TUI):

```
pip install snakesee[logo]
```

This installs the optional `rich-pixels` and `pillow` dependencies.

## conda / mamba[¶](#conda-mamba "Permanent link")

Install from Bioconda:

```
conda install -c bioconda snakesee
```

Or with mamba:

```
mamba install -c bioconda snakesee
```

## From source[¶](#from-source "Permanent link")

Clone and install in development mode:

```
git clone https://github.com/nh13/snakesee.git
cd snakesee
pip install -e '.[logo]'
```

## Verify installation[¶](#verify-installation "Permanent link")

```
snakesee --help
```

You should see:

```
usage: snakesee [-h] {watch,status} ...

positional arguments:
  {watch,status}
    watch         Watch a Snakemake workflow in real-time with a TUI dashboard.
    status        Show a one-time status snapshot (non-interactive).

options:
  -h, --help      show this help message and exit
```

## Optional: Logger Plugin[¶](#optional-logger-plugin "Permanent link")

For enhanced real-time monitoring with more accurate job timing, install the optional Snakemake logger plugin:

```
pip install snakemake-logger-plugin-snakesee
```

This plugin provides direct event streaming from Snakemake instead of log parsing. See [Usage](usage.html#enhanced-monitoring-with-logger-plugin) for details.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)