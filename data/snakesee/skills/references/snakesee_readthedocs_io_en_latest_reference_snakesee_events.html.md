[ ]
[ ]

[Skip to content](#snakesee.events)

snakesee

events

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
    - [constants](constants.html)
    - [ ]

      [estimation](estimation/index.html)

      estimation
      * [data\_loader](estimation/data_loader.html)
      * [estimator](estimation/estimator.html)
      * [pending\_inferrer](estimation/pending_inferrer.html)
      * [rule\_matcher](estimation/rule_matcher.html)
    - [estimator](estimator.html)
    - [ ]

      events

      [events](events.html)

      Table of contents
      * [events](#snakesee.events)
      * [Classes](#snakesee.events-classes)

        + [EventReader](#snakesee.events.EventReader)

          - [Attributes](#snakesee.events.EventReader-attributes)

            * [has\_events](#snakesee.events.EventReader.has_events)
          - [Functions](#snakesee.events.EventReader-functions)

            * [\_\_init\_\_](#snakesee.events.EventReader.__init__)
            * [read\_new\_events](#snakesee.events.EventReader.read_new_events)
            * [reset](#snakesee.events.EventReader.reset)
        + [EventType](#snakesee.events.EventType)
        + [SnakeseeEvent](#snakesee.events.SnakeseeEvent)

          - [Attributes](#snakesee.events.SnakeseeEvent-attributes)

            * [wildcards\_dict](#snakesee.events.SnakeseeEvent.wildcards_dict)
          - [Functions](#snakesee.events.SnakeseeEvent-functions)

            * [from\_json](#snakesee.events.SnakeseeEvent.from_json)
      * [Functions](#snakesee.events-functions)

        + [get\_event\_file\_path](#snakesee.events.get_event_file_path)
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

* [events](#snakesee.events)
* [Classes](#snakesee.events-classes)

  + [EventReader](#snakesee.events.EventReader)

    - [Attributes](#snakesee.events.EventReader-attributes)

      * [has\_events](#snakesee.events.EventReader.has_events)
    - [Functions](#snakesee.events.EventReader-functions)

      * [\_\_init\_\_](#snakesee.events.EventReader.__init__)
      * [read\_new\_events](#snakesee.events.EventReader.read_new_events)
      * [reset](#snakesee.events.EventReader.reset)
  + [EventType](#snakesee.events.EventType)
  + [SnakeseeEvent](#snakesee.events.SnakeseeEvent)

    - [Attributes](#snakesee.events.SnakeseeEvent-attributes)

      * [wildcards\_dict](#snakesee.events.SnakeseeEvent.wildcards_dict)
    - [Functions](#snakesee.events.SnakeseeEvent-functions)

      * [from\_json](#snakesee.events.SnakeseeEvent.from_json)
* [Functions](#snakesee.events-functions)

  + [get\_event\_file\_path](#snakesee.events.get_event_file_path)

# events

Event types and reader for Snakemake logger plugin integration.

This module provides types and utilities for reading real-time events
from the snakemake-logger-plugin-snakesee plugin. Events provide more
accurate and timely job status information than log parsing.

## Classes[¶](#snakesee.events-classes "Permanent link")

### EventReader [¶](#snakesee.events.EventReader "Permanent link")

Streaming reader for snakesee event files.

Reads events incrementally from a JSONL file, tracking the current
position to only return new events on subsequent calls.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `event_file` |  | Path to the event file. |

Source code in `snakesee/events.py`

|  |  |
| --- | --- |
| ``` 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 ``` | ``` class EventReader:     """Streaming reader for snakesee event files.      Reads events incrementally from a JSONL file, tracking the current     position to only return new events on subsequent calls.      Attributes:         event_file: Path to the event file.     """      def __init__(self, event_file: Path) -> None:         """Initialize the event reader.          Args:             event_file: Path to the event file.         """         self.event_file = event_file         self._offset: int = 0         self._lock = threading.RLock()      def read_new_events(self) -> list[SnakeseeEvent]:         """Read events added since last call.          Returns:             List of new events. Empty list if no new events or file doesn't exist.         """         if not self.event_file.exists():             return []          # Get current offset under lock (minimize lock hold time)         with self._lock:             offset = self._offset          # Perform file I/O without holding the lock to avoid blocking         events: list[SnakeseeEvent] = []         new_offset = offset         try:             with open(self.event_file, "r", encoding="utf-8") as f:                 f.seek(offset)                 for line in f:                     line = line.strip()                     if line:                         try:                             events.append(SnakeseeEvent.from_json(line))                         except (orjson.JSONDecodeError, ValueError, KeyError, TypeError) as e:                             # Skip malformed lines but log for debugging                             logger.debug(                                 "Skipping malformed event line: %s... (%s)",                                 line[:50],                                 e,                             )                             continue                 new_offset = f.tell()         except OSError as e:             # File access error - log and return empty list             logger.warning("Error reading event file %s: %s", self.event_file, e)             return events          # Update offset under lock         with self._lock:             self._offset = new_offset          return events      def reset(self) -> None:         """Reset reader to start of file.          Call this to re-read all events from the beginning.         """         with self._lock:             self._offset = 0      @property     def has_events(self) -> bool:         """Check if the event file exists and has content.          Returns:             True if event file exists and is non-empty.         """         if not self.event_file.exists():             return False         return self.event_file.stat().st_size > 0 ``` |

#### Attributes[¶](#snakesee.events.EventReader-attributes "Permanent link")

##### has\_events `property` [¶](#snakesee.events.EventReader.has_events "Permanent link")

```
has_events: bool
```

Check if the event file exists and has content.

Returns:

| Type | Description |
| --- | --- |
| `bool` | True if event file exists and is non-empty. |

#### Functions[¶](#snakesee.events.EventReader-functions "Permanent link")

##### \_\_init\_\_ [¶](#snakesee.events.EventReader.__init__ "Permanent link")

```
__init__(event_file: Path) -> None
```

Initialize the event reader.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `event_file` | `Path` | Path to the event file. | *required* |

Source code in `snakesee/events.py`

|  |  |
| --- | --- |
| ``` 126 127 128 129 130 131 132 133 134 ``` | ``` def __init__(self, event_file: Path) -> None:     """Initialize the event reader.      Args:         event_file: Path to the event file.     """     self.event_file = event_file     self._offset: int = 0     self._lock = threading.RLock() ``` |

##### read\_new\_events [¶](#snakesee.events.EventReader.read_new_events "Permanent link")

```
read_new_events() -> list[SnakeseeEvent]
```

Read events added since last call.

Returns:

| Type | Description |
| --- | --- |
| `list[[SnakeseeEvent](index.html#snakesee.events.SnakeseeEvent "SnakeseeEvent            dataclass    (snakesee.events.SnakeseeEvent)")]` | List of new events. Empty list if no new events or file doesn't exist. |

Source code in `snakesee/events.py`

|  |  |
| --- | --- |
| ``` 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 ``` | ``` def read_new_events(self) -> list[SnakeseeEvent]:     """Read events added since last call.      Returns:         List of new events. Empty list if no new events or file doesn't exist.     """     if not self.event_file.exists():         return []      # Get current offset under lock (minimize lock hold time)     with self._lock:         offset = self._offset      # Perform file I/O without holding the lock to avoid blocking     events: list[SnakeseeEvent] = []     new_offset = offset     try:         with open(self.event_file, "r", encoding="utf-8") as f:             f.seek(offset)             for line in f:                 line = line.strip()                 if line:                     try:                         events.append(SnakeseeEvent.from_json(line))                     except (orjson.JSONDecodeError, ValueError, KeyError, TypeError) as e:                         # Skip malformed lines but log for debugging                         logger.debug(                             "Skipping malformed event line: %s... (%s)",                             line[:50],                             e,                         )                         continue             new_offset = f.tell()     except OSError as e:         # File access error - log and return empty list         logger.warning("Error reading event file %s: %s", self.event_file, e)         return events      # Update offset under lock     with self._lock:         self._offset = new_offset      return events ``` |

##### reset [¶](#snakesee.events.EventReader.reset "Permanent link")

```
reset() -> None
```

Reset reader to start of file.

Call this to re-read all events from the beginning.

Source code in `snakesee/events.py`

|  |  |
| --- | --- |
| ``` 180 181 182 183 184 185 186 ``` | ``` def reset(self) -> None:     """Reset reader to start of file.      Call this to re-read all events from the beginning.     """     with self._lock:         self._offset = 0 ``` |

### EventType [¶](#snakesee.events.EventType "Permanent link")

Bases: `str`, `Enum`

Event types from the snakesee logger plugin.

These mirror the event types defined in the logger plugin.

Source code in `snakesee/events.py`

|  |  |
| --- | --- |
| ``` 23 24 25 26 27 28 29 30 31 32 33 34 ``` | ``` class EventType(str, Enum):     """Event types from the snakesee logger plugin.      These mirror the event types defined in the logger plugin.     """      WORKFLOW_STARTED = "workflow_started"     JOB_SUBMITTED = "job_submitted"     JOB_STARTED = "job_started"     JOB_FINISHED = "job_finished"     JOB_ERROR = "job_error"     PROGRESS = "progress" ``` |

### SnakeseeEvent `dataclass` [¶](#snakesee.events.SnakeseeEvent "Permanent link")

A single event from the logger plugin.

This is a frozen dataclass to ensure events are immutable once parsed.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `event_type` | `[EventType](index.html#snakesee.events.EventType "EventType (snakesee.events.EventType)")` | Type of the event. |
| `timestamp` | `float` | Unix timestamp when the event occurred. |
| `job_id` | `int | None` | Snakemake job ID (for job events). |
| `rule_name` | `str | None` | Name of the rule (for job events). |
| `wildcards` | `tuple[tuple[str, str], ...] | None` | Wildcard values for the job. |
| `threads` | `int | None` | Number of threads allocated to the job. |
| `resources` | `tuple[tuple[str, Any], ...] | None` | Resource requirements for the job. |
| `input_files` | `tuple[str, ...] | None` | Tuple of input file paths. |
| `output_files` | `tuple[str, ...] | None` | Tuple of output file paths. |
| `duration` | `float | None` | Job duration in seconds (for finished/error events). |
| `error_message` | `str | None` | Error message (for error events). |
| `completed_jobs` | `int | None` | Number of completed jobs (for progress events). |
| `total_jobs` | `int | None` | Total number of jobs (for progress events). |
| `workflow_id` | `str | None` | Unique workflow identifier. |

Source code in `snakesee/events.py`

|  |  |
| --- | --- |
| ``` 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 ``` | ``` @dataclass(frozen=True, slots=True) class SnakeseeEvent:     """A single event from the logger plugin.      This is a frozen dataclass to ensure events are immutable once parsed.      Attributes:         event_type: Type of the event.         timestamp: Unix timestamp when the event occurred.         job_id: Snakemake job ID (for job events).         rule_name: Name of the rule (for job events).         wildcards: Wildcard values for the job