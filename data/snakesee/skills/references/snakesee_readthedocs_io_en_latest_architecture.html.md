[ ]
[ ]

[Skip to content](#snakesee-architecture)

snakesee

Snakesee Architecture

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](index.html)
* [ ]

  Snakesee Architecture

  [Snakesee Architecture](architecture.html)

  Table of contents
  + [Module Structure](#module-structure)
  + [Key Design Patterns](#key-design-patterns)

    - [1. Dependency Injection for Testability](#1-dependency-injection-for-testability)
    - [2. Deferred Imports to Avoid Circular Dependencies](#2-deferred-imports-to-avoid-circular-dependencies)
    - [3. Plugin Architecture](#3-plugin-architecture)
    - [4. Centralized Configuration](#4-centralized-configuration)
    - [5. Application-Specific Exceptions](#5-application-specific-exceptions)
  + [Data Flow](#data-flow)

    - [Workflow Monitoring](#workflow-monitoring)
    - [Time Estimation](#time-estimation)
  + [Testing Strategy](#testing-strategy)
  + [Future Refactoring Notes](#future-refactoring-notes)

    - [parser/core.py Split (Recommended)](#parsercorepy-split-recommended)
    - [tui/monitor.py Split (Optional)](#tuimonitorpy-split-optional)
  + [Security Considerations](#security-considerations)
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

* [Module Structure](#module-structure)
* [Key Design Patterns](#key-design-patterns)

  + [1. Dependency Injection for Testability](#1-dependency-injection-for-testability)
  + [2. Deferred Imports to Avoid Circular Dependencies](#2-deferred-imports-to-avoid-circular-dependencies)
  + [3. Plugin Architecture](#3-plugin-architecture)
  + [4. Centralized Configuration](#4-centralized-configuration)
  + [5. Application-Specific Exceptions](#5-application-specific-exceptions)
* [Data Flow](#data-flow)

  + [Workflow Monitoring](#workflow-monitoring)
  + [Time Estimation](#time-estimation)
* [Testing Strategy](#testing-strategy)
* [Future Refactoring Notes](#future-refactoring-notes)

  + [parser/core.py Split (Recommended)](#parsercorepy-split-recommended)
  + [tui/monitor.py Split (Optional)](#tuimonitorpy-split-optional)
* [Security Considerations](#security-considerations)

# Snakesee Architecture[¶](#snakesee-architecture "Permanent link")

This document describes the architecture and key design decisions in snakesee.

## Module Structure[¶](#module-structure "Permanent link")

```
snakesee/
├── __init__.py          # Public API exports
├── cli.py               # Command-line interface (defopt-based)
├── constants.py         # Centralized configuration constants
├── events.py            # Event file reading and streaming
├── exceptions.py        # Application-specific exceptions
├── models.py            # Core data models (JobInfo, WorkflowProgress, etc.)
├── estimator.py         # Time estimation orchestration
├── formatting.py        # Duration and time formatting utilities
├── profile.py           # Portable timing profile storage
├── utils.py             # Shared utility functions
├── validation.py        # State comparison utilities
├── variance.py          # Variance calculation for confidence
│
├── tui/                 # Terminal user interface (Rich-based)
│   ├── __init__.py      # TUI module exports
│   └── monitor.py       # WorkflowMonitorTUI class
│
├── parser/              # Log parsing and metadata extraction
│   ├── __init__.py      # Public parser API
│   ├── core.py          # Core parsing functions
│   ├── line_parser.py   # Log line parsing
│   ├── log_reader.py    # Log file reading with caching
│   └── patterns.py      # Centralized regex patterns
│
├── estimation/          # Time estimation algorithms
│   ├── __init__.py
│   ├── estimator.py     # Main TimeEstimator class
│   ├── data_loader.py   # Data loading from metadata/events
│   └── strategies.py    # Weighting strategies (index/time)
│
├── plugins/             # Tool-specific progress parsing
│   ├── __init__.py      # Plugin registry and API
│   ├── base.py          # ToolProgressPlugin base class
│   ├── loader.py        # File-based plugin loading
│   ├── discovery.py     # Entry point plugin discovery
│   ├── registry.py      # Plugin lookup functions
│   └── (tool plugins)   # BWA, samtools, STAR, etc.
│
└── state/               # Unified workflow state management
    ├── __init__.py      # State module exports
    ├── clock.py         # Injectable clock for testability
    ├── config.py        # EstimationConfig and related
    ├── paths.py         # WorkflowPaths centralized path resolution
    ├── job_registry.py  # JobRegistry - job state tracking
    ├── rule_registry.py # RuleRegistry - rule statistics
    └── workflow_state.py # WorkflowState - top-level container
```

## Key Design Patterns[¶](#key-design-patterns "Permanent link")

### 1. Dependency Injection for Testability[¶](#1-dependency-injection-for-testability "Permanent link")

The `Clock` protocol enables deterministic testing of time-dependent code:

```
from snakesee.state import FrozenClock, set_clock

def test_elapsed_time():
    clock = FrozenClock(1000.0)
    set_clock(clock)

    # Test with frozen time
    clock.advance(60.0)  # Advance by 1 minute
```

### 2. Deferred Imports to Avoid Circular Dependencies[¶](#2-deferred-imports-to-avoid-circular-dependencies "Permanent link")

Many modules use deferred imports inside functions to break circular dependencies:

```
def my_function():
    # Deferred import to avoid circular dependency
    from snakesee.models import JobInfo
    ...
```

This pattern is intentional and documented in `TYPE_CHECKING` blocks for type hints.

### 3. Plugin Architecture[¶](#3-plugin-architecture "Permanent link")

Plugins are discovered from multiple sources:

1. **Built-in plugins**: Shipped with snakesee (BWA, samtools, etc.)
2. **User plugins**: `~/.snakesee/plugins/*.py`
3. **Entry points**: Third-party packages via `pyproject.toml`

Plugins must implement `ToolProgressPlugin` and are validated for:
- API version compatibility
- Required interface methods
- Valid property values

### 4. Centralized Configuration[¶](#4-centralized-configuration "Permanent link")

Constants are organized in `constants.py` using frozen dataclasses:

```
@dataclass(frozen=True)
class RefreshRateConfig:
    min_rate: float = 0.5
    max_rate: float = 60.0
    default_rate: float = 1.0

REFRESH_RATE_CONFIG = RefreshRateConfig()
```

Estimation-specific configuration is in `state/config.py`.

### 5. Application-Specific Exceptions[¶](#5-application-specific-exceptions "Permanent link")

Custom exception hierarchy for precise error handling:

```
SnakeseeError (base)
├── WorkflowError
│   ├── WorkflowNotFoundError
│   └── WorkflowParseError
├── ProfileError
│   ├── ProfileNotFoundError
│   └── InvalidProfileError
├── PluginError
│   ├── PluginLoadError
│   └── PluginExecutionError
└── ConfigurationError
```

## Data Flow[¶](#data-flow "Permanent link")

### Workflow Monitoring[¶](#workflow-monitoring "Permanent link")

1. **CLI** receives user command (`watch`, `status`, etc.)
2. **Parser** reads `.snakemake/` directory metadata
3. **State** modules maintain current workflow state
4. **Estimator** calculates time estimates from historical data
5. **TUI** renders real-time dashboard

### Time Estimation[¶](#time-estimation "Permanent link")

1. **DataLoader** loads timing data from metadata files or events
2. **RuleRegistry** tracks per-rule statistics
3. **Estimator** applies weighting strategies (index or time-based)
4. **Variance** calculates confidence intervals

## Testing Strategy[¶](#testing-strategy "Permanent link")

* **Unit tests**: Test individual components in isolation
* **Property-based tests**: Use Hypothesis for edge cases
* **Benchmark tests**: Track performance regressions
* **Integration tests**: Test end-to-end workflows

Minimum coverage requirement: 65%

## Future Refactoring Notes[¶](#future-refactoring-notes "Permanent link")

### parser/core.py Split (Recommended)[¶](#parsercorepy-split-recommended "Permanent link")

The `parser/core.py` could be split into focused modules:

1. **parser/metadata.py**: Metadata file parsing
2. `MetadataRecord`, `parse_metadata_files`, `parse_metadata_files_full`
3. `collect_rule_code_hashes`, `_calculate_input_size`
4. **parser/stats.py**: Timing statistics collection
5. `collect_rule_timing_stats`, `collect_wildcard_timing_stats`
6. `_build_wildcard_stats_for_key`
7. **parser/workflow.py**: Workflow state assembly
8. `parse_workflow_state`, `is_workflow_running`
9. `_determine_final_workflow_status`, `_reconcile_job_lists`
10. **parser/utils.py**: Utility functions
11. `_parse_wildcards`, `_parse_positive_int`, `_parse_non_negative_int`
12. `calculate_input_size`, `estimate_input_size_from_output`

The `parser/__init__.py` already acts as a facade, so this split would be
backward-compatible.

### tui/monitor.py Split (Optional)[¶](#tuimonitorpy-split-optional "Permanent link")

The `tui/monitor.py` could be further split using MVC pattern:

1. **tui/model.py**: State and data management
2. **tui/view.py**: Rich console rendering
3. **tui/controller.py**: Keyboard and refresh handling
4. **tui/**init**.py**: WorkflowMonitorTUI facade

## Security Considerations[¶](#security-considerations "Permanent link")

* **File size limits**: Prevent DoS from malicious files
* **Plugin security**: Warn on symlinks and world-writable directories
* **Input validation**: Validate all external input (metadata, logs)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)