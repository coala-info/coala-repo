[ ]
[ ]

[Skip to content](#snakesee.parser.job_tracker)

snakesee

job\_tracker

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
      * [ ]

        job\_tracker

        [job\_tracker](job_tracker.html)

        Table of contents
        + [job\_tracker](#snakesee.parser.job_tracker)
        + [Classes](#snakesee.parser.job_tracker-classes)

          - [JobLifecycleTracker](#snakesee.parser.job_tracker.JobLifecycleTracker)

            * [Functions](#snakesee.parser.job_tracker.JobLifecycleTracker-functions)

              + [\_\_init\_\_](#snakesee.parser.job_tracker.JobLifecycleTracker.__init__)
              + [finish\_job](#snakesee.parser.job_tracker.JobLifecycleTracker.finish_job)
              + [get\_completed\_jobs](#snakesee.parser.job_tracker.JobLifecycleTracker.get_completed_jobs)
              + [get\_job\_log](#snakesee.parser.job_tracker.JobLifecycleTracker.get_job_log)
              + [get\_running\_jobs](#snakesee.parser.job_tracker.JobLifecycleTracker.get_running_jobs)
              + [is\_job\_started](#snakesee.parser.job_tracker.JobLifecycleTracker.is_job_started)
              + [reset](#snakesee.parser.job_tracker.JobLifecycleTracker.reset)
              + [set\_job\_log](#snakesee.parser.job_tracker.JobLifecycleTracker.set_job_log)
              + [start\_job](#snakesee.parser.job_tracker.JobLifecycleTracker.start_job)
              + [update\_job](#snakesee.parser.job_tracker.JobLifecycleTracker.update_job)
          - [StartedJobData](#snakesee.parser.job_tracker.StartedJobData)
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

* [job\_tracker](#snakesee.parser.job_tracker)
* [Classes](#snakesee.parser.job_tracker-classes)

  + [JobLifecycleTracker](#snakesee.parser.job_tracker.JobLifecycleTracker)

    - [Functions](#snakesee.parser.job_tracker.JobLifecycleTracker-functions)

      * [\_\_init\_\_](#snakesee.parser.job_tracker.JobLifecycleTracker.__init__)
      * [finish\_job](#snakesee.parser.job_tracker.JobLifecycleTracker.finish_job)
      * [get\_completed\_jobs](#snakesee.parser.job_tracker.JobLifecycleTracker.get_completed_jobs)
      * [get\_job\_log](#snakesee.parser.job_tracker.JobLifecycleTracker.get_job_log)
      * [get\_running\_jobs](#snakesee.parser.job_tracker.JobLifecycleTracker.get_running_jobs)
      * [is\_job\_started](#snakesee.parser.job_tracker.JobLifecycleTracker.is_job_started)
      * [reset](#snakesee.parser.job_tracker.JobLifecycleTracker.reset)
      * [set\_job\_log](#snakesee.parser.job_tracker.JobLifecycleTracker.set_job_log)
      * [start\_job](#snakesee.parser.job_tracker.JobLifecycleTracker.start_job)
      * [update\_job](#snakesee.parser.job_tracker.JobLifecycleTracker.update_job)
  + [StartedJobData](#snakesee.parser.job_tracker.StartedJobData)

# job\_tracker

Job lifecycle tracking from start to completion.

## Classes[¶](#snakesee.parser.job_tracker-classes "Permanent link")

### JobLifecycleTracker [¶](#snakesee.parser.job_tracker.JobLifecycleTracker "Permanent link")

Tracks jobs from start to completion.

Maintains state for started jobs, finished job IDs, and completed
jobs with full timing information.

Source code in `snakesee/parser/job_tracker.py`

|  |  |
| --- | --- |
| ``` 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 ``` | ``` class JobLifecycleTracker:     """Tracks jobs from start to completion.      Maintains state for started jobs, finished job IDs, and completed     jobs with full timing information.     """      __slots__ = (         "_completed_jobs",         "_finished_jobids",         "_job_logs",         "_started_jobs",     )      def __init__(self) -> None:         """Initialize the job tracker."""         self._started_jobs: dict[str, StartedJobData] = {}         self._finished_jobids: set[str] = set()         self._completed_jobs: list[JobInfo] = []         self._job_logs: dict[str, str] = {}      def start_job(         self,         jobid: str,         rule: str,         start_time: float | None = None,         wildcards: dict[str, str] | None = None,         threads: int | None = None,     ) -> None:         """Record a job starting.          Args:             jobid: Unique job identifier.             rule: Name of the rule.             start_time: Unix timestamp when job started.             wildcards: Wildcard values for this job.             threads: Number of threads allocated.         """         if jobid not in self._started_jobs:             self._started_jobs[jobid] = StartedJobData(                 rule=rule,                 start_time=start_time,                 wildcards=wildcards,                 threads=threads,             )      def update_job(         self,         jobid: str,         wildcards: dict[str, str] | None = None,         threads: int | None = None,     ) -> None:         """Update an existing job's metadata.          Args:             jobid: Job identifier.             wildcards: Wildcard values to update.             threads: Thread count to update.         """         if jobid in self._started_jobs:             if wildcards is not None:                 self._started_jobs[jobid]["wildcards"] = wildcards             if threads is not None:                 self._started_jobs[jobid]["threads"] = threads      def set_job_log(self, jobid: str, log_path: str) -> None:         """Set the log file path for a job.          Args:             jobid: Job identifier.             log_path: Path to the log file.         """         self._job_logs[jobid] = log_path      def get_job_log(self, jobid: str) -> str | None:         """Get the log file path for a job.          Args:             jobid: Job identifier.          Returns:             Log file path or None if not set.         """         return self._job_logs.get(jobid)      def finish_job(self, jobid: str, end_time: float | None = None) -> JobInfo | None:         """Record a job finishing.          Args:             jobid: Job identifier.             end_time: Unix timestamp when job finished.          Returns:             JobInfo for the completed job, or None if job was not tracked.         """         self._finished_jobids.add(jobid)          if jobid in self._started_jobs:             job_data = self._started_jobs[jobid]             log_path = self._job_logs.get(jobid)             job_info = JobInfo(                 rule=job_data["rule"],                 job_id=jobid,                 start_time=job_data["start_time"],                 end_time=end_time,                 wildcards=job_data["wildcards"],                 threads=job_data["threads"],                 log_file=Path(log_path) if log_path else None,             )             self._completed_jobs.append(job_info)             # Clean up started job data to prevent memory growth             del self._started_jobs[jobid]             # Also clean up the job log entry             self._job_logs.pop(jobid, None)             return job_info         return None      def get_running_jobs(self) -> list[JobInfo]:         """Get list of jobs that started but haven't finished.          Returns:             List of JobInfo for running jobs.         """         running: list[JobInfo] = []         for jobid, job_data in self._started_jobs.items():             if jobid not in self._finished_jobids:                 log_path = self._job_logs.get(jobid)                 running.append(                     JobInfo(                         rule=job_data["rule"],                         job_id=jobid,                         start_time=job_data["start_time"],                         wildcards=job_data["wildcards"],                         threads=job_data["threads"],                         log_file=Path(log_path) if log_path else None,                     )                 )         return running      def get_completed_jobs(self) -> list[JobInfo]:         """Get list of completed jobs sorted by end time (newest first).          Returns:             List of JobInfo for completed jobs.         """         return sorted(             self._completed_jobs,             key=lambda j: j.end_time or 0,             reverse=True,         )      def is_job_started(self, jobid: str) -> bool:         """Check if a job has been started.          Args:             jobid: Job identifier.          Returns:             True if the job has been started.         """         return jobid in self._started_jobs      def reset(self) -> None:         """Clear all job tracking state."""         self._started_jobs.clear()         self._finished_jobids.clear()         self._completed_jobs.clear()         self._job_logs.clear() ``` |

#### Functions[¶](#snakesee.parser.job_tracker.JobLifecycleTracker-functions "Permanent link")

##### \_\_init\_\_ [¶](#snakesee.parser.job_tracker.JobLifecycleTracker.__init__ "Permanent link")

```
__init__() -> None
```

Initialize the job tracker.

Source code in `snakesee/parser/job_tracker.py`

|  |  |
| --- | --- |
| ``` 32 33 34 35 36 37 ``` | ``` def __init__(self) -> None:     """Initialize the job tracker."""     self._started_jobs: dict[str, StartedJobData] = {}     self._finished_jobids: set[str] = set()     self._completed_jobs: list[JobInfo] = []     self._job_logs: dict[str, str] = {} ``` |

##### finish\_job [¶](#snakesee.parser.job_tracker.JobLifecycleTracker.finish_job "Permanent link")

```
finish_job(jobid: str, end_time: float | None = None) -> JobInfo | None
```

Record a job finishing.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `jobid` | `str` | Job identifier. | *required* |
| `end_time` | `float | None` | Unix timestamp when job finished. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `[JobInfo](../index.html#snakesee.models.JobInfo "JobInfo            dataclass    (snakesee.models.JobInfo)") | None` | JobInfo for the completed job, or None if job was not tracked. |

Source code in `snakesee/parser/job_tracker.py`

|  |  |
| --- | --- |
| ``` 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 ``` | ``` def finish_job(self, jobid: str, end_time: float | None = None) -> JobInfo | None:     """Record a job finishing.      Args:         jobid: Job identifier.         end_time: Unix timestamp when job finished.      Returns:         JobInfo for the completed job, or None if job was not tracked.     """     self._finished_jobids.add(jobid)      if jobid in self._started_jobs:         job_data = self._started_jobs[jobid]         log_path = self._job_logs.get(jobid)         job_info = JobInfo(             rule=job_data["rule"],             job_id=jobid,             start_time=job_data["start_time"],             end_time=end_time,             wildcards=job_data["wildcards"],             threads=job_data["threads"],             log_file=Path(log_path) if log_path else None,         )         self._completed_jobs.append(job_info)         # Clean up started job data to prevent memory growth         del self._started_jobs[jobid]         # Also clean up the job log entry         self._job_logs.pop(jobid, None)         return job_info     return None ``` |

##### get\_completed\_jobs [¶](#snakesee.parser.job_tracker.JobLifecycleTracker.get_completed_jobs "Permanent link")

```
get_completed_jobs() -> list[JobInfo]
```

Get list of completed jobs sorted by end time (newest first).

Returns:

| Type | Description |
| --- | --- |
| `list[[JobInfo](../index.html#snakesee.models.JobInfo "JobInfo            dataclass    (snakesee.models.JobInfo)")]` | List of JobInfo for completed jobs. |

Source code in `snakesee/parser/job_tracker.py`

|  |  |
| --- | --- |
| ``` 157 158 159 160 161 162 163 164 165 166 167 ``` | ``` def get_completed_jobs(self) -> list[JobInfo]:     """Get list of completed jobs sorted by end time (newest first).      Returns:         List of JobInfo for completed jobs.     """     return sorted(         self._completed_jobs,         key=lambda j: j.end_time or 0,         reverse=True,     ) ``` |

#####