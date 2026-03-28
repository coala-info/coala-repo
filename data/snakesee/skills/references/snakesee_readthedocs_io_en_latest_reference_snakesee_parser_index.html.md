[ ]
[ ]

[Skip to content](#snakesee.parser)

snakesee

parser

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

* [parser](#snakesee.parser)
* [Classes](#snakesee.parser-classes)

  + [FailureTracker](#snakesee.parser.FailureTracker)

    - [Functions](#snakesee.parser.FailureTracker-functions)

      * [\_\_init\_\_](#snakesee.parser.FailureTracker.__init__)
      * [get\_failed\_jobs](#snakesee.parser.FailureTracker.get_failed_jobs)
      * [record\_failure](#snakesee.parser.FailureTracker.record_failure)
      * [reset](#snakesee.parser.FailureTracker.reset)
  + [IncrementalLogReader](#snakesee.parser.IncrementalLogReader)

    - [Attributes](#snakesee.parser.IncrementalLogReader-attributes)

      * [completed\_jobs](#snakesee.parser.IncrementalLogReader.completed_jobs)
      * [failed\_jobs](#snakesee.parser.IncrementalLogReader.failed_jobs)
      * [progress](#snakesee.parser.IncrementalLogReader.progress)
      * [running\_jobs](#snakesee.parser.IncrementalLogReader.running_jobs)
    - [Functions](#snakesee.parser.IncrementalLogReader-functions)

      * [\_\_init\_\_](#snakesee.parser.IncrementalLogReader.__init__)
      * [read\_new\_lines](#snakesee.parser.IncrementalLogReader.read_new_lines)
      * [reset](#snakesee.parser.IncrementalLogReader.reset)
      * [set\_log\_path](#snakesee.parser.IncrementalLogReader.set_log_path)
  + [JobLifecycleTracker](#snakesee.parser.JobLifecycleTracker)

    - [Functions](#snakesee.parser.JobLifecycleTracker-functions)

      * [\_\_init\_\_](#snakesee.parser.JobLifecycleTracker.__init__)
      * [finish\_job](#snakesee.parser.JobLifecycleTracker.finish_job)
      * [get\_completed\_jobs](#snakesee.parser.JobLifecycleTracker.get_completed_jobs)
      * [get\_job\_log](#snakesee.parser.JobLifecycleTracker.get_job_log)
      * [get\_running\_jobs](#snakesee.parser.JobLifecycleTracker.get_running_jobs)
      * [is\_job\_started](#snakesee.parser.JobLifecycleTracker.is_job_started)
      * [reset](#snakesee.parser.JobLifecycleTracker.reset)
      * [set\_job\_log](#snakesee.parser.JobLifecycleTracker.set_job_log)
      * [start\_job](#snakesee.parser.JobLifecycleTracker.start_job)
      * [update\_job](#snakesee.parser.JobLifecycleTracker.update_job)
  + [LogFilePosition](#snakesee.parser.LogFilePosition)

    - [Attributes](#snakesee.parser.LogFilePosition-attributes)

      * [offset](#snakesee.parser.LogFilePosition.offset)
    - [Functions](#snakesee.parser.LogFilePosition-functions)

      * [\_\_init\_\_](#snakesee.parser.LogFilePosition.__init__)
      * [check\_rotation](#snakesee.parser.LogFilePosition.check_rotation)
      * [clamp\_to\_size](#snakesee.parser.LogFilePosition.clamp_to_size)
      * [reset](#snakesee.parser.LogFilePosition.reset)
  + [LogLineParser](#snakesee.parser.LogLineParser)

    - [Functions](#snakesee.parser.LogLineParser-functions)

      * [flush\_pending\_error](#snakesee.parser.LogLineParser.flush_pending_error)
      * [parse\_line](#snakesee.parser.LogLineParser.parse_line)
      * [reset](#snakesee.parser.LogLineParser.reset)
  + [MetadataRecord](#snakesee.parser.MetadataRecord)

    - [Attributes](#snakesee.parser.MetadataRecord-attributes)

      * [duration](#snakesee.parser.MetadataRecord.duration)
    - [Functions](#snakesee.parser.MetadataRecord-functions)

      * [to\_job\_info](#snakesee.parser.MetadataRecord.to_job_info)
  + [ParseEvent](#snakesee.parser.ParseEvent)
  + [ParseEventType](#snakesee.parser.ParseEventType)
  + [ParsingContext](#snakesee.parser.ParsingContext)

    - [Functions](#snakesee.parser.ParsingContext-functions)

      * [get\_pending\_error](#snakesee.parser.ParsingContext.get_pending_error)
      * [has\_pending\_error](#snakesee.parser.ParsingContext.has_pending_error)
      * [reset\_for\_new\_rule](#snakesee.parser.ParsingContext.reset_for_new_rule)
      * [start\_error\_block](#snakesee.parser.ParsingContext.start_error_block)
  + [StartedJobData](#snakesee.parser.StartedJobData)
* [Functions](#snakesee.parser-functions)

  + [calculate\_input\_size](#snakesee.parser.calculate_input_size)
  + [collect\_rule\_code\_hashes](#snakesee.parser.collect_rule_code_hashes)
  + [collect\_rule\_timing\_stats](#snakesee.parser.collect_rule_timing_stats)
  + [collect\_wildcard\_timing\_stats](#snakesee.parser.collect_wildcard_timing_stats)
  + [estimate\_input\_size\_from\_output](#snakesee.parser.estimate_input_size_from_output)
  + [is\_workflow\_running](#snakesee.parser.is_workflow_running)
  + [parse\_all\_jobs\_from\_log](#snakesee.parser.parse_all_jobs_from_log)
  + [parse\_completed\_jobs\_from\_log](#snakesee.parser.parse_completed_jobs_from_log)
  + [parse\_failed\_jobs\_from\_log](#snakesee.parser.parse_failed_jobs_from_log)
  + [parse\_incomplete\_jobs](#snakesee.parser.parse_incomplete_jobs)
  + [parse\_job\_stats\_counts\_from\_log](#snakesee.parser.parse_job_stats_counts_from_log)
  + [parse\_job\_stats\_from\_log](#snakesee.parser.parse_job_stats_from_log)
  + [parse\_metadata\_files](#snakesee.parser.parse_metadata_files)
  + [parse\_metadata\_files\_full](#snakesee.parser.parse_metadata_files_full)
  + [parse\_progress\_from\_log](#snakesee.parser.parse_progress_from_log)
  + [parse\_rules\_from\_log](#snakesee.parser.parse_rules_from_log)
  + [parse\_running\_jobs\_from\_log](#snakesee.parser.parse_running_jobs_from_log)
  + [parse\_threads\_from\_log](#snakesee.parser.parse_threads_from_log)
  + [parse\_workflow\_state](#snakesee.parser.parse_workflow_state)
* [Modules](#snakesee.parser-modules)

  + [core](#snakesee.parser.core)

    - [Classes](#snakesee.parser.core-classes)

      * [MetadataRecord](#snakesee.parser.core.MetadataRecord)

        + [Attributes](#snakesee.parser.core.MetadataRecord-attributes)
        + [Functions](#snakesee.parser.core.MetadataRecord-functions)
    - [Functions](#snakesee.parser.core-functions)

      * [calculate\_input\_size](#snakesee.parser.core.calculate_input_size)
      * [collect\_rule\_code\_hashes](#snakesee.parser.core.collect_rule_code_hashes)
      * [collect\_rule\_timing\_stats](#snakesee.parser.core.collect_rule_timing_stats)
      * [collect\_wildcard\_timing\_stats](#snakesee.parser.core.collect_wildcard_timing_stats)
      * [estimate\_input\_size\_from\_output](#snakesee.parser.core.estimate_input_size_from_output)
      * [is\_workflow\_running](#snakesee.parser.core.is_workflow_running)
      * [parse\_all\_jobs\_from\_log](#snakesee.parser.core.parse_all_jobs_from_log)
      * [parse\_completed\_jobs\_from\_log](#snakesee.parser.core.parse_completed_jobs_from_log)
      * [parse\_failed\_jobs\_from\_log](#snakesee.parser.core.parse_failed_jobs_from_log)
      * [parse\_incomplete\_jobs](#snakesee.parser.core.parse_incomplete_jobs)
      * [parse\_job\_stats\_counts\_from\_log](#snakesee.parser.core.parse_job_stats_counts_from_log)
      * [parse\_job\_stats\_from\_log](#snakesee.parser.core.parse_job_stats_from_log)
      * [parse\_metadata\_files](#snakesee.parser.core.parse_metadata_files)
      * [parse\_metadata\_files\_full](#snakesee.parser.core.parse_metadata_files_full)
      * [parse\_progress\_from\_log](#snakesee.parser.core.parse_progress_from_log)
      * [parse\_rules\_from\_log](#snakesee.parser.core.parse_rules_from_log)
      * [parse\_running\_jobs\_from\_log](#snakesee.parser.core.parse_running_jobs_from_log)
      * [parse\_threads\_from\_log](#snakesee.parser.core.parse_threads_from_log)
      * [parse\_workflow\_state](#snakesee.parser.core.parse_workflow_state)
  + [failure\_tracker](#snakesee.parser.failure_tracker)

    - [Classes](#snakesee.parser.failure_tracker-classes)

      * [FailureTracker](#snakesee.parser.failure_tracker.FailureTracker)

        + [Functions](#snakesee.parser.failure_tracker.FailureTracker-functions)
  + [file\_position](#snakesee.parser.file_position)

    - [Classes](#snakesee.parser.file_position-classes)

      * [LogFilePosition](#snakesee.parser.file_position.LogFilePosition)

        + [Attributes](#snakesee.parser.file_position.LogFilePosition-attributes)
        + [Functions](#snakesee.parser.file_position.LogFilePosition-functions)
  + [job\_tracker](#snakesee.parser.job_tracker)

    - [Classes](#snakesee.parser.job_tracker-classes)

      * [JobLifecycleTracker](#snakesee.parser.job_tracker.JobLifecycleTracker)

        + [Functions](#snakesee.parser.job_tracker.JobLifecycleTracker-functions)
      * [StartedJobData](#snakesee.parser.job_tracker.StartedJobData)
  + [line\_parser](#snakesee.parser.line_parser)

    - [Classes](#snakesee.parser.line_parser-classes)

      * [LogLineParser](#snakesee.parser.line_parser.LogLineParser)

        + [Functions](#snakesee.parser.line_parser.LogLineParser-functions)
      * [ParseEvent](#snakesee.parser.line_parser.ParseEvent)
      * [ParseEventType](#snakesee.parser.line_parser.ParseEventType)
      * [ParsingContext](#snakesee.parser.line_parser.ParsingContext)

        + [Functions](#snakesee.parser.line_parser.ParsingContext-functions)
  + [log\_reader](#snakesee.parser.log_reader)

    - [Classes](#snakesee.parser.log_reader-classes)

      * [IncrementalLogReader](#snakesee.parser.log_reader.IncrementalLogReader)

        + [Attributes](#snakesee.parser.log_reader.IncrementalLogReader-attributes)
        + [Functions](#snakesee.parser.log_reader.IncrementalLogReader-functions)
  + [metadata](#snakesee.parser.metadata)

    - [Classes](#snakesee.parser.metadata-classes)

      * [MetadataRecord](#snakesee.parser.metadata.MetadataRecord)

        + [Attributes](#snakesee.parser.metadata.MetadataRecord-attributes)
        + [Functions](#snakesee.parser.metadata.MetadataRecord-functions)
    - [Functions](#snakesee.parser.metadata-functions)

      * [collect\_rule\_code\_hashes](#snakesee.parser.metadata.collect_rule_code_hashes)
      * [parse\_metadata\_files](#snakesee.parser.metadata.parse_metadata_files)
      * [parse\_metadata\_files\_full](#snakesee.parser.metadata.parse_metadata_files_full)
  + [patterns](#snakesee.parser.patterns)
  + [stats](#snakesee.parser.stats)

    - [Classes](#snakesee.parser.stats-classes)
    - [Functions](#snakesee.parser.stats-functions)

      * [collect\_rule\_timing\_stats](#snakesee.parser.stats.collect_rule_timing_stats)
      * [collect\_wildcard\_timing\_stats](#snakesee.parser.stats.collect_wildcard_timing_stats)
  + [utils](#snakesee.parser.utils)

    - [Functions](#snakesee.parser.utils-functions)

      * [calculate\_input\_size](#snakesee.parser.utils.calculate_input_size)
      * [estimate\_input\_size\_from\_output](#snakesee.parser.utils.estimate_input_size_from_output)

# parser

Parser package for Snakemake log file parsing.

This package provides components for parsing Snakemake log files:

* IncrementalLogReader: Streaming reader with position tracking
* LogFilePosition: File position and rotation tracking
* LogLineParser: Line-by-line parsing with context
* JobLifecycleTracker: Job start/finish tracking
* FailureTracker: Failure deduplication

The parser module is split into focused components:
- metadata.py: Metadata file parsing (MetadataRecord, parse\_metadata\_files)
- stats.py: Timing statistics collection (collect\_rule\_timing\_stats)
- utils.py: Utility functions (\_parse\_wildcards, calculate\_input\_size)
- core.py: Job parsing and workflow state assembly

Related modules

snakesee.estimation: Uses parsed timing data for ETA estimation
snakesee.models: JobInfo and WorkflowProgress data classes
snakesee.state.paths: WorkflowPaths for finding log files
snakesee.validation: Validates parsed state against events

## Classes[¶](#snakesee.parser-classes "Permanent link")

### FailureTracker [¶](#snakesee.parser.FailureTracker "Permanent link")

Tracks job failures with deduplication.

Prevents duplicate failure entries for the same rule/jobid combination.

Source code in `snakesee/parser/failure_tracker.py`

|  |  |
| --- | --- |
| ``` 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 ``` | ``` class FailureTracker:     """Tracks job failures with deduplication.      Prevents duplicate failure entries for the same rule/jobid combination.     """      __slots__ = ("_failed_jobs", "_seen_failures")      def __init__(self) -> None:         """Initialize the failure tracker."""         self._failed_jobs: list[JobInfo] = []   