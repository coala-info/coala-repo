[ ]
[ ]

[Skip to content](#snakesee.parser.metadata)

snakesee

metadata

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
      * [core](core.html)
      * [failure\_tracker](failure_tracker.html)
      * [file\_position](file_position.html)
      * [job\_tracker](job_tracker.html)
      * [line\_parser](line_parser.html)
      * [log\_reader](log_reader.html)
      * [ ]

        metadata

        [metadata](metadata.html)

        Table of contents
        + [metadata](#snakesee.parser.metadata)
        + [Classes](#snakesee.parser.metadata-classes)

          - [MetadataRecord](#snakesee.parser.metadata.MetadataRecord)

            * [Attributes](#snakesee.parser.metadata.MetadataRecord-attributes)

              + [duration](#snakesee.parser.metadata.MetadataRecord.duration)
            * [Functions](#snakesee.parser.metadata.MetadataRecord-functions)

              + [to\_job\_info](#snakesee.parser.metadata.MetadataRecord.to_job_info)
        + [Functions](#snakesee.parser.metadata-functions)

          - [collect\_rule\_code\_hashes](#snakesee.parser.metadata.collect_rule_code_hashes)
          - [parse\_metadata\_files](#snakesee.parser.metadata.parse_metadata_files)
          - [parse\_metadata\_files\_full](#snakesee.parser.metadata.parse_metadata_files_full)
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

* [metadata](#snakesee.parser.metadata)
* [Classes](#snakesee.parser.metadata-classes)

  + [MetadataRecord](#snakesee.parser.metadata.MetadataRecord)

    - [Attributes](#snakesee.parser.metadata.MetadataRecord-attributes)

      * [duration](#snakesee.parser.metadata.MetadataRecord.duration)
    - [Functions](#snakesee.parser.metadata.MetadataRecord-functions)

      * [to\_job\_info](#snakesee.parser.metadata.MetadataRecord.to_job_info)
* [Functions](#snakesee.parser.metadata-functions)

  + [collect\_rule\_code\_hashes](#snakesee.parser.metadata.collect_rule_code_hashes)
  + [parse\_metadata\_files](#snakesee.parser.metadata.parse_metadata_files)
  + [parse\_metadata\_files\_full](#snakesee.parser.metadata.parse_metadata_files_full)

# metadata

Metadata file parsing for Snakemake workflows.

This module handles parsing of .snakemake/metadata/ files which contain
information about completed jobs, including timing, wildcards, and code.

Note: Currently (Snakemake <= 8.x), metadata files do NOT store wildcards.
Wildcards are only available from live log events during the current session.
This means combination-based estimates (wildcard+threads) only work for jobs
that ran in the current session.

TODO: Once https://github.com/snakemake/snakemake/pull/3888 is merged and
released, metadata files will include wildcards, enabling historical
combination-based estimates across sessions.

## Classes[¶](#snakesee.parser.metadata-classes "Permanent link")

### MetadataRecord `dataclass` [¶](#snakesee.parser.metadata.MetadataRecord "Permanent link")

Single metadata file parsed data for efficient single-pass collection.

Contains all fields needed by various collection functions so we only
read each metadata file once.

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 ``` | ``` @dataclass(frozen=True, slots=True) class MetadataRecord:     """Single metadata file parsed data for efficient single-pass collection.      Contains all fields needed by various collection functions so we only     read each metadata file once.     """      rule: str     start_time: float | None = None     end_time: float | None = None     wildcards: dict[str, str] | None = None     input_size: int | None = None     code_hash: str | None = None      @property     def duration(self) -> float | None:         """Calculate duration from start and end times."""         if self.start_time is not None and self.end_time is not None:             return self.end_time - self.start_time         return None      def to_job_info(self) -> JobInfo:         """Convert to JobInfo for compatibility with existing code."""         return JobInfo(             rule=self.rule,             start_time=self.start_time,             end_time=self.end_time,             wildcards=self.wildcards,             input_size=self.input_size,         ) ``` |

#### Attributes[¶](#snakesee.parser.metadata.MetadataRecord-attributes "Permanent link")

##### duration `property` [¶](#snakesee.parser.metadata.MetadataRecord.duration "Permanent link")

```
duration: float | None
```

Calculate duration from start and end times.

#### Functions[¶](#snakesee.parser.metadata.MetadataRecord-functions "Permanent link")

##### to\_job\_info [¶](#snakesee.parser.metadata.MetadataRecord.to_job_info "Permanent link")

```
to_job_info() -> JobInfo
```

Convert to JobInfo for compatibility with existing code.

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 56 57 58 59 60 61 62 63 64 ``` | ``` def to_job_info(self) -> JobInfo:     """Convert to JobInfo for compatibility with existing code."""     return JobInfo(         rule=self.rule,         start_time=self.start_time,         end_time=self.end_time,         wildcards=self.wildcards,         input_size=self.input_size,     ) ``` |

## Functions[¶](#snakesee.parser.metadata-functions "Permanent link")

### collect\_rule\_code\_hashes [¶](#snakesee.parser.metadata.collect_rule_code_hashes "Permanent link")

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

### parse\_metadata\_files [¶](#snakesee.parser.metadata.parse_metadata_files "Permanent link")

```
parse_metadata_files(metadata_dir: Path, progress_callback: ProgressCallback | None = None) -> Iterator[JobInfo]
```

Parse completed job information from Snakemake metadata files.

Reads JSON metadata files from .snakemake/metadata/ to extract
timing information for completed jobs, including input file sizes.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `metadata_dir` | `Path` | Path to .snakemake/metadata/ directory. | *required* |
| `progress_callback` | `ProgressCallback | None` | Optional callback(current, total) for progress reporting. | `None` |

Yields:

| Type | Description |
| --- | --- |
| `[JobInfo](../index.html#snakesee.models.JobInfo "JobInfo            dataclass    (snakesee.models.JobInfo)")` | JobInfo instances for each completed job found. |

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 ``` | ``` def parse_metadata_files(     metadata_dir: Path,     progress_callback: ProgressCallback | None = None, ) -> Iterator[JobInfo]:     """     Parse completed job information from Snakemake metadata files.      Reads JSON metadata files from .snakemake/metadata/ to extract     timing information for completed jobs, including input file sizes.      Args:         metadata_dir: Path to .snakemake/metadata/ directory.         progress_callback: Optional callback(current, total) for progress reporting.      Yields:         JobInfo instances for each completed job found.     """     for _path, data in iterate_metadata_files(metadata_dir, progress_callback):         rule = data.get("rule")         starttime = data.get("starttime")         endtime = data.get("endtime")          if rule is not None and starttime is not None and endtime is not None:             # Extract wildcards if present (Snakemake stores as dict)             wildcards_data = data.get("wildcards")             wildcards: dict[str, str] | None = None             if isinstance(wildcards_data, dict):                 wildcards = {str(k): str(v) for k, v in wildcards_data.items()}              yield JobInfo(                 rule=rule,                 start_time=starttime,                 end_time=endtime,                 wildcards=wildcards,                 input_size=_calculate_input_size(data.get("input")),             ) ``` |

### parse\_metadata\_files\_full [¶](#snakesee.parser.metadata.parse_metadata_files_full "Permanent link")

```
parse_metadata_files_full(metadata_dir: Path, progress_callback: ProgressCallback | None = None) -> Iterator[MetadataRecord]
```

Parse all metadata from Snakemake metadata files in a single pass.

This is more efficient than calling parse\_metadata\_files and
collect\_rule\_code\_hashes separately, as it reads each file only once.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `metadata_dir` | `Path` | Path to .snakemake/metadata/ directory. | *required* |
| `progress_callback` | `ProgressCallback | None` | Optional callback(current, total) for progress reporting. | `None` |

Yields:

| Type | Description |
| --- | --- |
| `[MetadataRecord](index.html#snakesee.parser.metadata.MetadataRecord "MetadataRecord            dataclass    (snakesee.parser.metadata.MetadataRecord)")` | MetadataRecord instances containing timing and code hash data. |

Source code in `snakesee/parser/metadata.py`

|  |  |
| --- | --- |
| ``` 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 ``` | ``` def parse_metadata_files_full(     metadata_dir: Path,     progress_callback: ProgressCallback | None = None, ) -> Iterator[MetadataRecord]:     """     Parse all metadata from Snakemake metadata files in a single pass.      This is more efficient than calling parse_metadata_files and     collect_rule_code_hashes separately, as it reads each file only once.      Args:         metadata_dir: Path to .snakemake/metadata/ directory.         progress_callback: Optional callback(current, total) for progress reporting.      Yields:         MetadataRecord instances containing timing and code hash data.     """     for _path, data in iterate_metadata_files(metadata_dir, progress_callback):         rule = data.get("rule")         if rule is None:             continue          # Extract timing data         starttime = data.get("starttime")         endtime = data.get("endtime")          # Extract wildcards if present         wildcards_data = data.get("wildcards