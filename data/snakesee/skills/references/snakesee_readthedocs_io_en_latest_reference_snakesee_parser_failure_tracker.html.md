[ ]
[ ]

[Skip to content](#snakesee.parser.failure_tracker)

snakesee

failure\_tracker

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
      * [ ]

        failure\_tracker

        [failure\_tracker](failure_tracker.html)

        Table of contents
        + [failure\_tracker](#snakesee.parser.failure_tracker)
        + [Classes](#snakesee.parser.failure_tracker-classes)

          - [FailureTracker](#snakesee.parser.failure_tracker.FailureTracker)

            * [Functions](#snakesee.parser.failure_tracker.FailureTracker-functions)

              + [\_\_init\_\_](#snakesee.parser.failure_tracker.FailureTracker.__init__)
              + [get\_failed\_jobs](#snakesee.parser.failure_tracker.FailureTracker.get_failed_jobs)
              + [record\_failure](#snakesee.parser.failure_tracker.FailureTracker.record_failure)
              + [reset](#snakesee.parser.failure_tracker.FailureTracker.reset)
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

* [failure\_tracker](#snakesee.parser.failure_tracker)
* [Classes](#snakesee.parser.failure_tracker-classes)

  + [FailureTracker](#snakesee.parser.failure_tracker.FailureTracker)

    - [Functions](#snakesee.parser.failure_tracker.FailureTracker-functions)

      * [\_\_init\_\_](#snakesee.parser.failure_tracker.FailureTracker.__init__)
      * [get\_failed\_jobs](#snakesee.parser.failure_tracker.FailureTracker.get_failed_jobs)
      * [record\_failure](#snakesee.parser.failure_tracker.FailureTracker.record_failure)
      * [reset](#snakesee.parser.failure_tracker.FailureTracker.reset)

# failure\_tracker

Failure tracking with deduplication.

## Classes[¶](#snakesee.parser.failure_tracker-classes "Permanent link")

### FailureTracker [¶](#snakesee.parser.failure_tracker.FailureTracker "Permanent link")

Tracks job failures with deduplication.

Prevents duplicate failure entries for the same rule/jobid combination.

Source code in `snakesee/parser/failure_tracker.py`

|  |  |
| --- | --- |
| ``` 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 ``` | ``` class FailureTracker:     """Tracks job failures with deduplication.      Prevents duplicate failure entries for the same rule/jobid combination.     """      __slots__ = ("_failed_jobs", "_seen_failures")      def __init__(self) -> None:         """Initialize the failure tracker."""         self._failed_jobs: list[JobInfo] = []         self._seen_failures: set[tuple[str, str | None]] = set()      def record_failure(         self,         rule: str,         jobid: str | None = None,         wildcards: dict[str, str] | None = None,         threads: int | None = None,         log_file: Path | None = None,     ) -> bool:         """Record a job failure.          Args:             rule: Name of the failed rule.             jobid: Job identifier (if known).             wildcards: Wildcard values.             threads: Thread count.             log_file: Path to the log file.          Returns:             True if this is a new failure, False if duplicate.         """         key = (rule, jobid)         if key in self._seen_failures:             return False          self._seen_failures.add(key)         self._failed_jobs.append(             JobInfo(                 rule=rule,                 job_id=jobid,                 wildcards=wildcards,                 threads=threads,                 log_file=log_file,             )         )         return True      def get_failed_jobs(self) -> list[JobInfo]:         """Get list of failed jobs.          Returns:             List of JobInfo for failed jobs.         """         return list(self._failed_jobs)      def reset(self) -> None:         """Clear all failure tracking state."""         self._failed_jobs.clear()         self._seen_failures.clear() ``` |

#### Functions[¶](#snakesee.parser.failure_tracker.FailureTracker-functions "Permanent link")

##### \_\_init\_\_ [¶](#snakesee.parser.failure_tracker.FailureTracker.__init__ "Permanent link")

```
__init__() -> None
```

Initialize the failure tracker.

Source code in `snakesee/parser/failure_tracker.py`

|  |  |
| --- | --- |
| ``` 16 17 18 19 ``` | ``` def __init__(self) -> None:     """Initialize the failure tracker."""     self._failed_jobs: list[JobInfo] = []     self._seen_failures: set[tuple[str, str | None]] = set() ``` |

##### get\_failed\_jobs [¶](#snakesee.parser.failure_tracker.FailureTracker.get_failed_jobs "Permanent link")

```
get_failed_jobs() -> list[JobInfo]
```

Get list of failed jobs.

Returns:

| Type | Description |
| --- | --- |
| `list[[JobInfo](../index.html#snakesee.models.JobInfo "JobInfo            dataclass    (snakesee.models.JobInfo)")]` | List of JobInfo for failed jobs. |

Source code in `snakesee/parser/failure_tracker.py`

|  |  |
| --- | --- |
| ``` 57 58 59 60 61 62 63 ``` | ``` def get_failed_jobs(self) -> list[JobInfo]:     """Get list of failed jobs.      Returns:         List of JobInfo for failed jobs.     """     return list(self._failed_jobs) ``` |

##### record\_failure [¶](#snakesee.parser.failure_tracker.FailureTracker.record_failure "Permanent link")

```
record_failure(rule: str, jobid: str | None = None, wildcards: dict[str, str] | None = None, threads: int | None = None, log_file: Path | None = None) -> bool
```

Record a job failure.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `rule` | `str` | Name of the failed rule. | *required* |
| `jobid` | `str | None` | Job identifier (if known). | `None` |
| `wildcards` | `dict[str, str] | None` | Wildcard values. | `None` |
| `threads` | `int | None` | Thread count. | `None` |
| `log_file` | `Path | None` | Path to the log file. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `bool` | True if this is a new failure, False if duplicate. |

Source code in `snakesee/parser/failure_tracker.py`

|  |  |
| --- | --- |
| ``` 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 ``` | ``` def record_failure(     self,     rule: str,     jobid: str | None = None,     wildcards: dict[str, str] | None = None,     threads: int | None = None,     log_file: Path | None = None, ) -> bool:     """Record a job failure.      Args:         rule: Name of the failed rule.         jobid: Job identifier (if known).         wildcards: Wildcard values.         threads: Thread count.         log_file: Path to the log file.      Returns:         True if this is a new failure, False if duplicate.     """     key = (rule, jobid)     if key in self._seen_failures:         return False      self._seen_failures.add(key)     self._failed_jobs.append(         JobInfo(             rule=rule,             job_id=jobid,             wildcards=wildcards,             threads=threads,             log_file=log_file,         )     )     return True ``` |

##### reset [¶](#snakesee.parser.failure_tracker.FailureTracker.reset "Permanent link")

```
reset() -> None
```

Clear all failure tracking state.

Source code in `snakesee/parser/failure_tracker.py`

|  |  |
| --- | --- |
| ``` 65 66 67 68 ``` | ``` def reset(self) -> None:     """Clear all failure tracking state."""     self._failed_jobs.clear()     self._seen_failures.clear() ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)