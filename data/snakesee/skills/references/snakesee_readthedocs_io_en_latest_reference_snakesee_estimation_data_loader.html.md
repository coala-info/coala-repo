[ ]
[ ]

[Skip to content](#snakesee.estimation.data_loader)

snakesee

data\_loader

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](../../../index.html)
* [Snakesee Architecture](../../../architecture.html)
* [Installation](../../../installation.html)
* [Usage](../../../usage.html)
* [x]

  Reference

  Reference
  + [x]

    [snakesee](../index.html)

    snakesee
    - [cli](../cli.html)
    - [constants](../constants.html)
    - [x]

      [estimation](index.html)

      estimation
      * [ ]

        data\_loader

        [data\_loader](data_loader.html)

        Table of contents
        + [data\_loader](#snakesee.estimation.data_loader)
        + [Classes](#snakesee.estimation.data_loader-classes)

          - [HistoricalDataLoader](#snakesee.estimation.data_loader.HistoricalDataLoader)

            * [Functions](#snakesee.estimation.data_loader.HistoricalDataLoader-functions)

              + [\_\_init\_\_](#snakesee.estimation.data_loader.HistoricalDataLoader.__init__)
              + [load\_from\_events](#snakesee.estimation.data_loader.HistoricalDataLoader.load_from_events)
              + [load\_from\_metadata](#snakesee.estimation.data_loader.HistoricalDataLoader.load_from_metadata)
        + [Functions](#snakesee.estimation.data_loader-functions)
      * [estimator](estimator.html)
      * [pending\_inferrer](pending_inferrer.html)
      * [rule\_matcher](rule_matcher.html)
    - [estimator](../estimator.html)
    - [events](../events.html)
    - [exceptions](../exceptions.html)
    - [formatting](../formatting.html)
    - [log\_handler\_script](../log_handler_script.html)
    - [logging](../logging.html)
    - [models](../models.html)
    - [parameter\_validation](../parameter_validation.html)
    - [ ]

      [parser](../parser/index.html)

      parser
      * [core](../parser/core.html)
      * [failure\_tracker](../parser/failure_tracker.html)
      * [file\_position](../parser/file_position.html)
      * [job\_tracker](../parser/job_tracker.html)
      * [line\_parser](../parser/line_parser.html)
      * [log\_reader](../parser/log_reader.html)
      * [metadata](../parser/metadata.html)
      * [patterns](../parser/patterns.html)
      * [stats](../parser/stats.html)
      * [utils](../parser/utils.html)
    - [ ]

      [plugins](../plugins/index.html)

      plugins
      * [base](../plugins/base.html)
      * [bwa](../plugins/bwa.html)
      * [discovery](../plugins/discovery.html)
      * [fastp](../plugins/fastp.html)
      * [fgbio](../plugins/fgbio.html)
      * [loader](../plugins/loader.html)
      * [registry](../plugins/registry.html)
      * [samtools](../plugins/samtools.html)
      * [star](../plugins/star.html)
    - [profile](../profile.html)
    - [ ]

      [state](../state/index.html)

      state
      * [clock](../state/clock.html)
      * [config](../state/config.html)
      * [job\_registry](../state/job_registry.html)
      * [paths](../state/paths.html)
      * [rule\_registry](../state/rule_registry.html)
      * [workflow\_state](../state/workflow_state.html)
    - [state\_comparison](../state_comparison.html)
    - [ ]

      [tui](../tui/index.html)

      tui
      * [monitor](../tui/monitor.html)
    - [types](../types.html)
    - [utils](../utils.html)
    - [validation](../validation.html)
    - [variance](../variance.html)

Table of contents

* [data\_loader](#snakesee.estimation.data_loader)
* [Classes](#snakesee.estimation.data_loader-classes)

  + [HistoricalDataLoader](#snakesee.estimation.data_loader.HistoricalDataLoader)

    - [Functions](#snakesee.estimation.data_loader.HistoricalDataLoader-functions)

      * [\_\_init\_\_](#snakesee.estimation.data_loader.HistoricalDataLoader.__init__)
      * [load\_from\_events](#snakesee.estimation.data_loader.HistoricalDataLoader.load_from_events)
      * [load\_from\_metadata](#snakesee.estimation.data_loader.HistoricalDataLoader.load_from_metadata)
* [Functions](#snakesee.estimation.data_loader-functions)

# data\_loader

Historical data loading for time estimation.

## Classes[¶](#snakesee.estimation.data_loader-classes "Permanent link")

### HistoricalDataLoader [¶](#snakesee.estimation.data_loader.HistoricalDataLoader "Permanent link")

Loads timing data from metadata and events files.

Provides methods to load historical execution data from:
- .snakemake/metadata/ directory (from previous Snakemake runs)
- .snakesee\_events.jsonl file (from snakesee monitoring)

Source code in `snakesee/estimation/data_loader.py`

|  |  |
| --- | --- |
| ``` 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 ``` | ``` class HistoricalDataLoader:     """Loads timing data from metadata and events files.      Provides methods to load historical execution data from:     - .snakemake/metadata/ directory (from previous Snakemake runs)     - .snakesee_events.jsonl file (from snakesee monitoring)     """      def __init__(         self,         registry: "RuleRegistry",         use_wildcard_conditioning: bool = False,     ) -> None:         """Initialize the loader.          Args:             registry: RuleRegistry to load data into.             use_wildcard_conditioning: Whether to record wildcard-specific stats.         """         self._registry = registry         self.use_wildcard_conditioning = use_wildcard_conditioning         self.code_hash_to_rules: dict[str, set[str]] = {}      def load_from_metadata(         self,         metadata_dir: Path,         progress_callback: "ProgressCallback | None" = None,     ) -> None:         """Load historical execution times from .snakemake/metadata/.          Uses a single-pass parser for efficiency - reads each metadata file         only once to collect timing stats, code hashes, and wildcard stats.          Args:             metadata_dir: Path to .snakemake/metadata/ directory.             progress_callback: Optional callback(current, total) for progress.         """         hash_to_rules: dict[str, set[str]] = {}          for record in parse_metadata_files_full(metadata_dir, progress_callback):             duration = record.duration             end_time = record.end_time              if duration is not None and end_time is not None:                 wildcards = record.wildcards if self.use_wildcard_conditioning else None                 self._registry.record_completion(                     rule=record.rule,                     duration=duration,                     timestamp=end_time,                     wildcards=wildcards,                     input_size=record.input_size,                 )              if record.code_hash:                 if record.code_hash not in hash_to_rules:                     hash_to_rules[record.code_hash] = set()                 hash_to_rules[record.code_hash].add(record.rule)          self.code_hash_to_rules = hash_to_rules      def load_from_events(self, events_file: Path) -> bool:         """Load historical execution times from a snakesee events file.          Streams the events file line by line for memory efficiency.          Args:             events_file: Path to .snakesee_events.jsonl file.          Returns:             True if any wildcard data was found.         """         if not events_file.exists():             return False          has_wildcards = False          try:             with open(events_file, "r", encoding="utf-8") as f:                 for line in f:                     if not line.strip():                         continue                      # Skip excessively long lines to prevent memory issues                     if len(line) > MAX_EVENTS_LINE_LENGTH:                         logger.debug(                             "Skipping oversized line in events file: %d bytes (max %d)",                             len(line),                             MAX_EVENTS_LINE_LENGTH,                         )                         continue                      try:                         event = orjson.loads(line)                     except orjson.JSONDecodeError:                         continue                      if event.get("event_type") != "job_finished":                         continue                      duration = event.get("duration")                     timestamp = event.get("timestamp")                     rule_name = event.get("rule_name")                     wildcards = event.get("wildcards")                      if duration is None or timestamp is None or rule_name is None:                         continue                      wc_dict = wildcards if isinstance(wildcards, dict) else None                     self._registry.record_completion(                         rule=rule_name,                         duration=duration,                         timestamp=timestamp,                         wildcards=wc_dict,                     )                      if wc_dict:                         has_wildcards = True          except OSError as e:             logger.warning("Error reading events file %s: %s", events_file, e)             return False          return has_wildcards ``` |

#### Functions[¶](#snakesee.estimation.data_loader.HistoricalDataLoader-functions "Permanent link")

##### \_\_init\_\_ [¶](#snakesee.estimation.data_loader.HistoricalDataLoader.__init__ "Permanent link")

```
__init__(registry: RuleRegistry, use_wildcard_conditioning: bool = False) -> None
```

Initialize the loader.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `registry` | `[RuleRegistry](../index.html#snakesee.state.rule_registry.RuleRegistry "RuleRegistry (snakesee.state.rule_registry.RuleRegistry)")` | RuleRegistry to load data into. | *required* |
| `use_wildcard_conditioning` | `bool` | Whether to record wildcard-specific stats. | `False` |

Source code in `snakesee/estimation/data_loader.py`

|  |  |
| --- | --- |
| ``` 27 28 29 30 31 32 33 34 35 36 37 38 39 40 ``` | ``` def __init__(     self,     registry: "RuleRegistry",     use_wildcard_conditioning: bool = False, ) -> None:     """Initialize the loader.      Args:         registry: RuleRegistry to load data into.         use_wildcard_conditioning: Whether to record wildcard-specific stats.     """     self._registry = registry     self.use_wildcard_conditioning = use_wildcard_conditioning     self.code_hash_to_rules: dict[str, set[str]] = {} ``` |

##### load\_from\_events [¶](#snakesee.estimation.data_loader.HistoricalDataLoader.load_from_events "Permanent link")

```
load_from_events(events_file: Path) -> bool
```

Load historical execution times from a snakesee events file.

Streams the events file line by line for memory efficiency.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `events_file` | `Path` | Path to .snakesee\_events.jsonl file. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `bool` | True if any wildcard data was found. |

Source code in `snakesee/estimation/data_loader.py`

|  |  |
| --- | --- |
| ``` 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 ``` | ``` def load_from_events(self, events_file: Path) -> bool:     """Load historical execution times from a snakesee events file.      Streams the events file line by line for memory efficiency.      Args:         events_file: Path to .snakesee_events.jsonl file.      Returns:         True if any wildcard data was found.     """     if not events_file.exists():         return False      has_wildcards = False      try:         with open(events_file, "r", encoding="utf-8") as f:             for line in f:                 if not line.strip():                     continue                  # Skip excessively long lines to prevent memory issues                 if len(line) > MAX_EVENTS_LINE_LENGTH:                     logger.debug(                         "Skipping oversized line in events file: %d bytes (max %d)",                         len(line),                         MAX_EVENTS_LINE_LENGTH,                     )                     continue                  try:                     event = orjson.loads(line)                 except orjson.JSONDecodeError:                     continue                  if event.get("event_type") != "job_finished":                     continue                  duration = event.get("duration")                 timestamp = event.get("timestamp")                 rule_name = event.get("rule_name")                 wildcards = event.get("wildcards")                  if duration is None or timestamp is None or rule_name is None:                     continue                  wc_dict = wildcards if isinstance(wildcards, dict) else None                 self._registry.record_completion(                     rule=rule_name,                     duration=duration,                     timestamp=timestamp,                     wildcards=wc_dict,                 )                  if wc_dict:                     has_wildcards = True      except OSError as e:         logger.warning("Error reading events file %s: %s", events_file, e)         return False      return has_wildcards ``` |

##### load\_from\_metadata [¶](#snakesee.estimation.data_loader.HistoricalDataLoader.load_from_metadata "Permanent link")

```
load_from_metadata(metadata_dir: Path, progress_callback: ProgressCallback | None = None) -> None
```

Load historical execution times from .snakemake/metadata/.

Uses a single-pass parser for efficiency - reads each metadata file
only once to collect timing stats, code hashes, and wildcard stats.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `metadata_dir` | `Path` | Path to .snakemake/metadata/ directory. | *required* |
| `progress_callback` | `ProgressCallback | None` | Optional callback(current, total) for progress. | `None` |

Source code in `snakesee/estimation/data_loader.py`

|  |  |
| --- | --- |
| ``` 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 ``` | ``` def load_from_metadata(     self,     metadata_dir: Path,     progress_callback: "ProgressCallback | None" = None, ) -> None:     """Load historical execution times from .snakemake/metadata/.      Uses a single-pass parser for efficiency - reads each metadata file     only once to collect timing stats, code hashes, and wildcard stats.      Args:         metadata_dir: Path to .snakemake/metadata/ directory.         pr