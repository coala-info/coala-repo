[ ]
[ ]

[Skip to content](#snakesee)

snakesee

snakesee

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [ ]

  snakesee

  [snakesee](index.html)

  Table of contents
  + [Features](#features)
  + [Quick Start](#quick-start)
  + [Documentation](#documentation)
  + [Links](#links)
* [Snakesee Architecture](architecture.html)
* [Installation](installation.html)
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

* [Features](#features)
* [Quick Start](#quick-start)
* [Documentation](#documentation)
* [Links](#links)

# snakesee[¶](#snakesee "Permanent link")

**A terminal UI for monitoring Snakemake workflows.**

snakesee provides a rich TUI dashboard for passively monitoring Snakemake workflows. It reads directly from the `.snakemake/` directory, requiring no special flags or configuration when running Snakemake.

## Features[¶](#features "Permanent link")

* **Zero configuration** - Works on any existing workflow without modification
* **Historical browsing** - Navigate through past workflow executions
* **Time estimation** - Predicts remaining time from historical data
* **Rich TUI** - Vim-style keyboard controls, filtering, and sorting
* **Multiple layouts** - Full, compact, and minimal display modes
* **Optional logger plugin** - Real-time event streaming for enhanced accuracy

## Quick Start[¶](#quick-start "Permanent link")

```
# Install
pip install snakesee

# Watch a workflow
cd /path/to/snakemake/workflow
snakesee watch

# Or get a one-time status
snakesee status
```

## Documentation[¶](#documentation "Permanent link")

* [Installation](installation.html) - How to install snakesee
* [Usage](usage.html) - CLI commands and TUI keyboard shortcuts

## Links[¶](#links "Permanent link")

* [GitHub Repository](https://github.com/nh13/snakesee)
* [PyPI Package](https://pypi.org/project/snakesee/)
* [Issue Tracker](https://github.com/nh13/snakesee/issues)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)