[ ]
[ ]

[Skip to content](#snakesee.parser.log_reader)

snakesee

log\_reader

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
      * [ ]

        log\_reader

        [log\_reader](log_reader.html)

        Table of contents
        + [log\_reader](#snakesee.parser.log_reader)
        + [Classes](#snakesee.parser.log_reader-classes)

          - [IncrementalLogReader](#snakesee.parser.log_reader.IncrementalLogReader)

            * [Attributes](#snakesee.parser.log_reader.IncrementalLogReader-attributes)

              + [completed\_jobs](#snakesee.parser.log_reader.IncrementalLogReader.completed_jobs)
              + [failed\_jobs](#snakesee.parser.log_reader.IncrementalLogReader.failed_jobs)
              + [progress](#snakesee.parser.log_reader.IncrementalLogReader.progress)
              + [running\_jobs](#snakesee.parser.log_reader.IncrementalLogReader.running_jobs)
            * [Functions](#snakesee.parser.log_reader.IncrementalLogReader-functions)

              + [\_\_init\_\_](#snakesee.parser.log_reader.IncrementalLogReader.__init__)
              + [read\_new\_lines](#snakesee.parser.log_reader.IncrementalLogReader.read_new_lines)
              + [reset](#snakesee.parser.log_reader.IncrementalLogReader.reset)
              + [set\_log\_path](#snakesee.parser.log_reader.IncrementalLogReader.set_log_path)
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

* [log\_reader](#snakesee.parser.log_reader)
* [Classes](#snakesee.parser.log_reader-classes)

  + [IncrementalLogReader](#snakesee.parser.log_reader.IncrementalLogReader)

    - [Attributes](#snakesee.parser.log_reader.IncrementalLogReader-attributes)

      * [completed\_jobs](#snakesee.parser.log_reader.IncrementalLogReader.completed_jobs)
      * [failed\_jobs](#snakesee.parser.log_reader.IncrementalLogReader.failed_jobs)
      * [progress](#snakesee.parser.log_reader.IncrementalLogReader.progress)
      * [running\_jobs](#snakesee.parser.log_reader.IncrementalLogReader.running_jobs)
    - [Functions](#snakesee.parser.log_reader.IncrementalLogReader-functions)

      * [\_\_init\_\_](#snakesee.parser.log_reader.IncrementalLogReader.__init__)
      * [read\_new\_lines](#snakesee.parser.log_reader.IncrementalLogReader.read_new_lines)
      * [reset](#snakesee.parser.log_reader.IncrementalLogReader.reset)
      * [set\_log\_path](#snakesee.parser.log_reader.IncrementalLogReader.set_log_path)

# log\_reader

Coordinator for incremental log reading.

## Classes[¶](#snakesee.parser.log_reader-classes "Permanent link")

### IncrementalLogReader [¶](#snakesee.parser.log_reader.IncrementalLogReader "Permanent link")

Streaming reader for Snakemake log files with position tracking.

Reads log lines incrementally, tracking the current file position to only
parse new content on subsequent calls. Maintains cumulative state for
running jobs, completed jobs, failed jobs, and progress.

Handles log file rotation by detecting inode changes or file truncation.

This is a coordinator class that delegates to specialized components:
- LogFilePosition: File position tracking and rotation detection
- LogLineParser: Log line parsing with context tracking
- JobLifecycleTracker: Job start/finish tracking
- FailureTracker: Failure deduplication

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `log_path` |  | Path to the log file being monitored. |

Source code in `snakesee/parser/log_reader.py`

|  |  |
| --- | --- |
| ``` 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 ``` | ``` class IncrementalLogReader:     """Streaming reader for Snakemake log files with position tracking.      Reads log lines incrementally, tracking the current file position to only     parse new content on subsequent calls. Maintains cumulative state for     running jobs, completed jobs, failed jobs, and progress.      Handles log file rotation by detecting inode changes or file truncation.      This is a coordinator class that delegates to specialized components:     - LogFilePosition: File position tracking and rotation detection     - LogLineParser: Log line parsing with context tracking     - JobLifecycleTracker: Job start/finish tracking     - FailureTracker: Failure deduplication      Attributes:         log_path: Path to the log file being monitored.     """      def __init__(self, log_path: Path) -> None:         """Initialize the incremental log reader.          Args:             log_path: Path to the Snakemake log file.         """         self.log_path = log_path         self._lock = threading.RLock()          # Delegate components         self._position = LogFilePosition(log_path)         self._parser = LogLineParser()         self._jobs = JobLifecycleTracker()         self._failures = FailureTracker()          # Progress state         self._completed: int = 0         self._total: int = 0      def reset(self) -> None:         """Reset reader to start of file and clear all state.          Call this when switching to a different log file or to re-read         from the beginning.         """         with self._lock:             self._reset_unlocked()      def set_log_path(self, log_path: Path) -> None:         """Change the log file being monitored.          Resets all state if the path changes.          Args:             log_path: New log file path.         """         with self._lock:             if log_path != self.log_path:                 self.log_path = log_path                 self._position = LogFilePosition(log_path)                 self._reset_unlocked()      def _reset_unlocked(self) -> None:         """Reset state without acquiring lock (caller must hold lock)."""         self._position.reset()         self._parser.reset()         self._jobs.reset()         self._failures.reset()         self._completed = 0         self._total = 0      def read_new_lines(self) -> int:         """Read and parse new lines from the log file.          Updates internal state based on new log content. This method         should be called periodically to process new log entries.          Returns:             Number of new lines processed.         """         if not self.log_path.exists():             return 0          with self._lock:             if self._position.check_rotation():                 # File was rotated - reset all state                 self._parser.reset()                 self._jobs.reset()                 self._failures.reset()                 self._completed = 0                 self._total = 0              lines_processed = 0             try:                 with open(self.log_path, "r", encoding="utf-8", errors="replace") as f:                     # Clamp offset to file bounds                     file_size = f.seek(0, 2)                     self._position.clamp_to_size(file_size)                     f.seek(self._position.offset)                      for line in f:                         self._process_line(line)                         lines_processed += 1                      self._position.offset = f.tell()                      # Flush any pending error at end of file                     if pending := self._parser.flush_pending_error():                         self._process_event(pending)             except FileNotFoundError:                 pass             except PermissionError as e:                 logger.warning("Permission denied reading log file %s: %s", self.log_path, e)             except OSError as e:                 logger.warning("Error reading log file %s: %s", self.log_path, e)              return lines_processed      def _process_line(self, line: str) -> None:         """Process a parsed line and update state.          Args:             line: Raw log line to process.         """         events = self._parser.parse_line(line)         for event in events:             self._process_event(event)      def _process_event(self, event: ParseEvent) -> None:         """Process a single parsed event and update state.          Args:             event: Parsed event to process.         """         if event.event_type == ParseEventType.PROGRESS:             completed = event.data["completed"]             total = event.data["total"]             if isinstance(completed, int) and isinstance(total, int):                 self._completed = completed                 self._total = total          elif event.event_type == ParseEventType.JOBID:             rule = event.data.get("rule")             if rule is not None:                 jobid = str(event.data["jobid"])                 if not self._jobs.is_job_started(jobid):                     timestamp = event.data.get("timestamp")                     wildcards = event.data.get("wildcards")                     threads = event.data.get("threads")                     self._jobs.start_job(                         jobid=jobid,                         rule=str(rule),                         start_time=float(timestamp)                         if isinstance(timestamp, (int, float))                         else None,                         wildcards=wildcards if isinstance(wildcards, dict) else None,                         threads=threads if isinstance(threads, int) else None,                     )                 log_path = event.data.get("log_path")                 if isinstance(log_path, str):                     self._jobs.set_job_log(jobid, log_path)          elif event.event_type == ParseEventType.WILDCARDS:             wc_jobid = event.data.get("jobid")             wc_wildcards = event.data.get("wildcards")             if isinstance(wc_jobid, str) and isinstance(wc_wildcards, dict):                 self._jobs.update_job(wc_jobid, wildcards=wc_wildcards)          elif event.event_type == ParseEventType.THREADS:             th_jobid = event.data.get("jobid")             th_threads = event.data.get("threads")             if isinstance(th_jobid, str) and isinstance(th_threads, int):                 self._jobs.update_job(th_jobid, threads=th_threads)          elif event.event_type == ParseEventType.LOG_PATH:             lp_jobid = event.data.get("jobid")             lp_path = event.data.get("log_path")             if isinstance(lp_jobid, str) and isinstance(lp_path, str):                 self._jobs.set_job_log(lp_jobid, lp_path)          elif event.event_type == ParseEventType.JOB_FINISHED:             fin_jobid = str(event.data["jobid"])             fin_timestamp = event.data.get("timestamp")             fin_end = float(fin_timestamp) if isinstance(fin_timestamp, (int, float)) else None             self._jobs.finish_job(fin_jobid, end_time=fin_end)          elif event.event_type == ParseEventType.ERROR:             err_rule = str(event.data["rule"])             err_jobid = event.data.get("jobid")             err_log = event.data.get("log_path")             err_wildcards = event.data.get("wildcards")             err_threads = event.data.get("threads")             self._failures.record_failure(                 rule=err_rule,                 jobid=str(err_jobid) if err_jobid is not None else None,                 wildcards=err_wildcards if isinstance(err_wildcards, dict) else None,                 threads=err_threads if isinstance(err_threads, int) else None,                 log_file=Path(err_log) if isinstance(err_log, str) else None,             )      @property     def progress(self) -> tuple[int, int]:         """Get current workflow progress.          Returns:             Tuple of (completed_count, total_count).         """         with self._lock:             return self._completed, self._total      @property     def running_jobs(self) -> list[JobInfo]:         """Get list of currently running jobs.          Returns:             List of JobInfo for jobs that started but haven't finished.         """ 