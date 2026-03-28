[ ]
[ ]

[Skip to content](#snakesee.parser.core)

snakesee

core

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
    - [ ]

      [estimation](../estimation/index.html)

      estimation
      * [data\_loader](../estimation/data_loader.html)
      * [estimator](../estimation/estimator.html)
      * [pending\_inferrer](../estimation/pending_inferrer.html)
      * [rule\_matcher](../estimation/rule_matcher.html)
    - [estimator](../estimator.html)
    - [events](../events.html)
    - [exceptions](../exceptions.html)
    - [formatting](../formatting.html)
    - [log\_handler\_script](../log_handler_script.html)
    - [logging](../logging.html)
    - [models](../models.html)
    - [parameter\_validation](../parameter_validation.html)
    - [x]

      [parser](index.html)

      parser
      * [ ]

        core

        [core](core.html)

        Table of contents
        + [core](#snakesee.parser.core)
        + [Classes](#snakesee.parser.core-classes)

          - [MetadataRecord](#snakesee.parser.core.MetadataRecord)

            * [Attributes](#snakesee.parser.core.MetadataRecord-attributes)

              + [duration](#snakesee.parser.core.MetadataRecord.duration)
            * [Functions](#snakesee.parser.core.MetadataRecord-functions)

              + [to\_job\_info](#snakesee.parser.core.MetadataRecord.to_job_info)
        + [Functions](#snakesee.parser.core-functions)

          - [calculate\_input\_size](#snakesee.parser.core.calculate_input_size)
          - [collect\_rule\_code\_hashes](#snakesee.parser.core.collect_rule_code_hashes)
          - [collect\_rule\_timing\_stats](#snakesee.parser.core.collect_rule_timing_stats)
          - [collect\_wildcard\_timing\_stats](#snakesee.parser.core.collect_wildcard_timing_stats)
          - [estimate\_input\_size\_from\_output](#snakesee.parser.core.estimate_input_size_from_output)
          - [is\_workflow\_running](#snakesee.parser.core.is_workflow_running)
          - [parse\_all\_jobs\_from\_log](#snakesee.parser.core.parse_all_jobs_from_log)
          - [parse\_completed\_jobs\_from\_log](#snakesee.parser.core.parse_completed_jobs_from_log)
          - [parse\_failed\_jobs\_from\_log](#snakesee.parser.core.parse_failed_jobs_from_log)
          - [parse\_incomplete\_jobs](#snakesee.parser.core.parse_incomplete_jobs)
          - [parse\_job\_stats\_counts\_from\_log](#snakesee.parser.core.parse_job_stats_counts_from_log)
          - [parse\_job\_stats\_from\_log](#snakesee.parser.core.parse_job_stats_from_log)
          - [parse\_metadata\_files](#snakesee.parser.core.parse_metadata_files)
          - [parse\_metadata\_files\_full](#snakesee.parser.core.parse_metadata_files_full)
          - [parse\_progress\_from\_log](#snakesee.parser.core.parse_progress_from_log)
          - [parse\_rules\_from\_log](#snakesee.parser.core.parse_rules_from_log)
          - [parse\_running\_jobs\_from\_log](#snakesee.parser.core.parse_running_jobs_from_log)
          - [parse\_threads\_from\_log](#snakesee.parser.core.parse_threads_from_log)
          - [parse\_workflow\_state](#snakesee.parser.core.parse_workflow_state)
      * [failure\_tracker](failure_tracker.html)
      * [file\_position](file_position.html)
      * [job\_tracker](job_tracker.html)
      * [line\_parser](line_parser.html)
      * [log\_reader](log_reader.html)
      * [metadata](metadata.html)
      * [patterns](patterns.html)
      * [stats](stats.html)
      * [utils](utils.html)
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

* [core](#snakesee.parser.core)
* [Classes](#snakesee.parser.core-classes)

  + [MetadataRecord](#snakesee.parser.core.MetadataRecord)

    - [Attributes](#snakesee.parser.core.MetadataRecord-attributes)

      * [duration](#snakesee.parser.core.MetadataRecord.duration)
    - [Functions](#snakesee.parser.core.MetadataRecord-functions)

      * [to\_job\_info](#snakesee.parser.core.MetadataRecord.to_job_info)
* [Functions](#snakesee.parser.core-functions)

  + [calculate\_input\_size](#snakesee.parser.core.calculate_input_size)
  + [collect\_rule\_code\_hashes](#snakesee.parser.core.collect_rule_code_hashes)
  + [collect\_rule\_timing\_stats](#snakesee.parser.core.collect_rule_timing_stats)
  + [collect\_wildcard\_timing\_stats](#snakesee.parser.core.collect_wildcard_timing_stats)
  + [estimate\_input\_size\_from\_output](#snakesee.parser.core.estimate_input_size_from_output)
  + [is\_workflow\_running](#snakesee.parser.core.is_workflow_running)
  + [parse\_all\_jobs\_from\_log](#snakesee.parser.core.parse_all_jobs_from_log)
  + [parse\_completed\_jobs\_from\_log](#snakesee.parser.core.parse_completed_jobs_from_log)
  + [parse\_failed\_jobs\_from\_log](#snakesee.parser.core.parse_failed_jobs_from_log)
  + [parse\_incomplete\_jobs](#snakesee.parser.core.parse_incomplete_jobs)
  + [parse\_job\_stats\_counts\_from\_log](#snakesee.parser.core.parse_job_stats_counts_from_log)
  + [parse\_job\_stats\_from\_log](#snakesee.parser.core.parse_job_stats_from_log)
  + [parse\_metadata\_files](#snakesee.parser.core.parse_metadata_files)
  + [parse\_metadata\_files\_full](#snakesee.parser.core.parse_metadata_files_full)
  + [parse\_progress\_from\_log](#snakesee.parser.core.parse_progress_from_log)
  + [parse\_rules\_from\_log](#snakesee.parser.core.parse_rules_from_log)
  + [parse\_running\_jobs\_from\_log](#snakesee.parser.core.parse_running_jobs_from_log)
  + [parse\_threads\_from\_log](#snakesee.parser.core.parse_threads_from_log)
  + [parse\_workflow\_state](#snakesee.parser.core.parse_workflow_state)

# core

Parsers for Snakemake log files and job tracking.

This module contains log file parsing functions for tracking running,
completed, and failed jobs. Metadata parsing has been moved to
snakesee.parser.metadata and statistics collection to snakesee.parser.stats.

## Classes[¶](#snakesee.parser.core-classes "Permanent link")

### MetadataRecord `dataclass` [¶](#snakesee.parser.core.MetadataRecord "Permanent link")

Single metadata file parsed data for efficient single-pass collection.

Contains all fields needed by various collection functions so we only
read each metadata file once.

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 ``` | ``` @dataclass(frozen=True, slots=True) class MetadataRecord:     """Single metadata file parsed data for efficient single-pass collection.      Contains all fields needed by various collection functions so we only     read each metadata file once.     """      rule: str     start_time: float | None = None     end_time: float | None = None     wildcards: dict[str, str] | None = None     input_size: int | None = None     code_hash: str | None = None      @property     def duration(self) -> float | None:         """Calculate duration from start and end times."""         if self.start_time is not None and self.end_time is not None:             return self.end_time - self.start_time         return None      def to_job_info(self) -> JobInfo:         """Convert to JobInfo for compatibility with existing code."""         return JobInfo(             rule=self.rule,             start_time=self.start_time,             end_time=self.end_time,             wildcards=self.wildcards,             input_size=self.input_size,         ) ``` |

#### Attributes[¶](#snakesee.parser.core.MetadataRecord-attributes "Permanent link")

##### duration `property` [¶](#snakesee.parser.core.MetadataRecord.duration "Permanent link")

```
duration: float | None
```

Calculate duration from start and end times.

#### Functions[¶](#snakesee.parser.core.MetadataRecord-functions "Permanent link")

##### to\_job\_info [¶](#snakesee.parser.core.MetadataRecord.to_job_info "Permanent link")

```
to_job_info() -> JobInfo
```

Convert to JobInfo for compatibility with existing code.

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 56 57 58 59 60 61 62 63 64 ``` | ``` def to_job_info(self) -> JobInfo:     """Convert to JobInfo for compatibility with existing code."""     return JobInfo(         rule=self.rule,         start_time=self.start_time,         end_time=self.end_time,         wildcards=self.wildcards,         input_size=self.input_size,     ) ``` |

## Functions[¶](#snakesee.parser.core-functions "Permanent link")

### calculate\_input\_size [¶](#snakesee.parser.core.calculate_input_size "Permanent link")

```
calculate_input_size(file_paths: list[Path]) -> int | None
```

Calculate total size of input files.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `file_paths` | `list[Path]` | List of input file paths. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `int | None` | Total size in bytes, or None if any file doesn't exist. |

Source code in `snakesee/parser/utils.py`

|  |  |
| --- | --- |
| ``` 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 ``` | ``` def calculate_input_size(file_paths: list[Path]) -> int | None:     """     Calculate total size of input files.      Args:         file_paths: List of input file paths.      Returns:         Total size in bytes, or None if any file doesn't exist.     """     total_size = 0     for path in file_paths:         try:             total_size += path.stat().st_size         except OSError:             return None  # File doesn't exist or can't be accessed     return total_size if file_paths else None ``` |

### collect\_rule\_code\_hashes [¶](#snakesee.parser.core.collect_rule_code_hashes "Permanent link")

```
collect_rule_code_hashes(metadata_dir: Path, progress_callback: ProgressCallback | None = None) -> dict[str, set[str]]
```

Collect code hashes for each rule from metadata files.

This enables detection of renamed rules by matching their shell code.
If two rules have the same code hash, they are likely the same rule
that was renamed.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `metadata_dir` | `Path` | Path to .snakemake/metadata/ directory. | *required* |
| `progress_callback` | `ProgressCallback | None` | Optional callback(current, total) for progress reporting. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `dict[str, set[str]]` | Dictionary mapping code\_hash -> set of rule names that use that code. |

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 ``` | ``` def collect_rule_code_hashes(     metadata_dir: Path,     progress_callback: ProgressCallback | None = None, ) -> dict[str, set[str]]:     """     Collect code hashes for each rule from metadata files.      This enables detection of renamed rules by matching their shell code.     If two rules have the same code hash, they are likely the same rule     that was renamed.      Args:         metadata_dir: Path to .snakemake/metadata/ directory.         progress_callback: Optional callback(current, total) for progress reporting.      Returns:         Dictionary mapping code_hash -> set of rule names that use that code.     """     hash_to_rules: dict[str, set[str]] = {}      if not metadata_dir.exists():         return hash_to_rules      # Use optimized iterate_metadata_files (6-7x faster than rglob)     for _path, data in iterate_metadata_files(         metadata_dir,         progress_callback,         sort_by_mtime=False,  # Order doesn't matter for code hash collection         use_cache=False,  # We need to read code field which isn't cached     ):         rule = data.get("rule")         code = data.get("code")          if rule and code:             # Normalize whitespace before hashing to handle formatting differences             normalized_code = " ".join(code.split())             code_hash = hashlib.sha256(normalized_code.encode()).hexdigest()[:16]              if code_hash not in hash_to_rules:                 hash_to_rules[code_hash] = set()             hash_to_rules[code_hash].add(rule)      return hash_to_rules ``` |

### collect\_rule\_timing\_stats [¶](#snakesee.parser.core.collect_rule_timing_stats "Permanent link")

```
collect_rule_timing_stats(metadata_dir: Path, progress_callback: ProgressCallback | None = None) -> dict[str, RuleTimingStats]
```

Collect historical timing statistics per rule from metadata.

Aggregates all completed job timings by rule name, sorted chronologically
by end time. Includes timestamps for time-based weighted estimation.
Input sizes are included when available from job metadata.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `metadata_dir` | `Path` | Path to .snakemake/metadata/ directory. | *required* |
| `progress_callback` | `ProgressCallback | None` | Optional callback(current, total) for progress reporting. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `dict[str, [RuleTimingStats](../index.html#snakesee.models.RuleTimingStats "RuleTimingStats            dataclass    (snakesee.models.RuleTimingStats)")]` | Dictionary mapping rule names to their timing statistics. |

Source code in `snakesee/parser/stats.py`

|  |  |
| --- | --- |
| ``` 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 ``` | ``` def collect_rule_timing_stats(     metadata_dir: Path,     progress_callback: ProgressCallback | 