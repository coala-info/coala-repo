[ ]
[ ]

[Skip to content](#snakesee.constants)

snakesee

constants

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](../../index.html)
* [Snakesee Architecture](../../architecture.html)
* [Installation](../../installation.html)
* [Usage](../../usage.html)
* [x]

  Reference

  Reference
  + [x]

    [snakesee](index.html)

    snakesee
    - [cli](cli.html)
    - [ ]

      constants

      [constants](constants.html)

      Table of contents
      * [constants](#snakesee.constants)
      * [Classes](#snakesee.constants-classes)

        + [CacheConfig](#snakesee.constants.CacheConfig)
        + [FileSizeLimits](#snakesee.constants.FileSizeLimits)
        + [RefreshRateConfig](#snakesee.constants.RefreshRateConfig)
    - [ ]

      [estimation](estimation/index.html)

      estimation
      * [data\_loader](estimation/data_loader.html)
      * [estimator](estimation/estimator.html)
      * [pending\_inferrer](estimation/pending_inferrer.html)
      * [rule\_matcher](estimation/rule_matcher.html)
    - [estimator](estimator.html)
    - [events](events.html)
    - [exceptions](exceptions.html)
    - [formatting](formatting.html)
    - [log\_handler\_script](log_handler_script.html)
    - [logging](logging.html)
    - [models](models.html)
    - [parameter\_validation](parameter_validation.html)
    - [ ]

      [parser](parser/index.html)

      parser
      * [core](parser/core.html)
      * [failure\_tracker](parser/failure_tracker.html)
      * [file\_position](parser/file_position.html)
      * [job\_tracker](parser/job_tracker.html)
      * [line\_parser](parser/line_parser.html)
      * [log\_reader](parser/log_reader.html)
      * [metadata](parser/metadata.html)
      * [patterns](parser/patterns.html)
      * [stats](parser/stats.html)
      * [utils](parser/utils.html)
    - [ ]

      [plugins](plugins/index.html)

      plugins
      * [base](plugins/base.html)
      * [bwa](plugins/bwa.html)
      * [discovery](plugins/discovery.html)
      * [fastp](plugins/fastp.html)
      * [fgbio](plugins/fgbio.html)
      * [loader](plugins/loader.html)
      * [registry](plugins/registry.html)
      * [samtools](plugins/samtools.html)
      * [star](plugins/star.html)
    - [profile](profile.html)
    - [ ]

      [state](state/index.html)

      state
      * [clock](state/clock.html)
      * [config](state/config.html)
      * [job\_registry](state/job_registry.html)
      * [paths](state/paths.html)
      * [rule\_registry](state/rule_registry.html)
      * [workflow\_state](state/workflow_state.html)
    - [state\_comparison](state_comparison.html)
    - [ ]

      [tui](tui/index.html)

      tui
      * [monitor](tui/monitor.html)
    - [types](types.html)
    - [utils](utils.html)
    - [validation](validation.html)
    - [variance](variance.html)

Table of contents

* [constants](#snakesee.constants)
* [Classes](#snakesee.constants-classes)

  + [CacheConfig](#snakesee.constants.CacheConfig)
  + [FileSizeLimits](#snakesee.constants.FileSizeLimits)
  + [RefreshRateConfig](#snakesee.constants.RefreshRateConfig)

# constants

Centralized constants for snakesee.

This module consolidates configuration constants and magic numbers
used across multiple modules to ensure consistency and make tuning easier.

Configuration is organized into two modules:

1. This module (constants.py): Runtime configuration
2. RefreshRateConfig: TUI refresh rates
3. CacheConfig: Caching behavior and TTLs
4. FileSizeLimits: Security limits for file parsing
5. snakesee.state.config: Estimation-specific configuration
6. EstimationConfig: Time estimation parameters
7. VarianceMultipliers: Variance settings per estimation method
8. ConfidenceWeights: Confidence calculation weights
9. ConfidenceThresholds: Decision thresholds
10. TimeConstants: Time-related constants

Note: This module defines STALE\_WORKFLOW\_THRESHOLD\_SECONDS (1800.0 seconds / 30 minutes),
which is imported by state.config.TimeConstants.stale\_workflow\_threshold to ensure
a single source of truth.

For estimation-specific configuration, see :class:`snakesee.state.config.EstimationConfig`.

## Classes[¶](#snakesee.constants-classes "Permanent link")

### CacheConfig `dataclass` [¶](#snakesee.constants.CacheConfig "Permanent link")

Configuration for caching behavior.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `default_tool_progress_ttl` | `float` | Default TTL for tool progress cache in seconds. |
| `adaptive_ttl_multiplier` | `float` | Multiplier for adaptive cache TTL based on refresh rate. |
| `max_cache_ttl` | `float` | Maximum cache TTL in seconds (cap for adaptive calculation). |
| `exists_cache_ttl` | `float` | TTL for filesystem existence check cache in seconds. |

Source code in `snakesee/constants.py`

|  |  |
| --- | --- |
| ``` 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 ``` | ``` @dataclass(frozen=True) class CacheConfig:     """Configuration for caching behavior.      Attributes:         default_tool_progress_ttl: Default TTL for tool progress cache in seconds.         adaptive_ttl_multiplier: Multiplier for adaptive cache TTL based on refresh rate.         max_cache_ttl: Maximum cache TTL in seconds (cap for adaptive calculation).         exists_cache_ttl: TTL for filesystem existence check cache in seconds.     """      default_tool_progress_ttl: float = 5.0     adaptive_ttl_multiplier: float = 2.5     max_cache_ttl: float = 15.0     exists_cache_ttl: float = 5.0 ``` |

### FileSizeLimits `dataclass` [¶](#snakesee.constants.FileSizeLimits "Permanent link")

Security limits for file sizes.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `max_metadata_file_size` | `int` | Maximum size in bytes for metadata files (10 MB). |
| `max_events_line_length` | `int` | Maximum line length in bytes for events file (1 MB). |

Source code in `snakesee/constants.py`

|  |  |
| --- | --- |
| ``` 62 63 64 65 66 67 68 69 70 71 72 ``` | ``` @dataclass(frozen=True) class FileSizeLimits:     """Security limits for file sizes.      Attributes:         max_metadata_file_size: Maximum size in bytes for metadata files (10 MB).         max_events_line_length: Maximum line length in bytes for events file (1 MB).     """      max_metadata_file_size: int = 10 * 1024 * 1024     max_events_line_length: int = 1 * 1024 * 1024 ``` |

### RefreshRateConfig `dataclass` [¶](#snakesee.constants.RefreshRateConfig "Permanent link")

Configuration for TUI refresh rate.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `min_rate` | `float` | Minimum refresh rate in seconds (fastest). |
| `max_rate` | `float` | Maximum refresh rate in seconds (slowest). |
| `default_rate` | `float` | Default refresh rate in seconds. |

Source code in `snakesee/constants.py`

|  |  |
| --- | --- |
| ``` 30 31 32 33 34 35 36 37 38 39 40 41 42 ``` | ``` @dataclass(frozen=True) class RefreshRateConfig:     """Configuration for TUI refresh rate.      Attributes:         min_rate: Minimum refresh rate in seconds (fastest).         max_rate: Maximum refresh rate in seconds (slowest).         default_rate: Default refresh rate in seconds.     """      min_rate: float = 0.5     max_rate: float = 60.0     default_rate: float = 1.0 ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)