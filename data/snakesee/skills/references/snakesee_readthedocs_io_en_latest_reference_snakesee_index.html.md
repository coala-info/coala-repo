[ ]
[ ]

[Skip to content](#snakesee)

snakesee

snakesee

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

* [snakesee](#snakesee)
* [Classes](#snakesee-classes)

  + [ConfigurationError](#snakesee.ConfigurationError)
  + [EventReader](#snakesee.EventReader)

    - [Attributes](#snakesee.EventReader-attributes)

      * [has\_events](#snakesee.EventReader.has_events)
    - [Functions](#snakesee.EventReader-functions)

      * [\_\_init\_\_](#snakesee.EventReader.__init__)
      * [read\_new\_events](#snakesee.EventReader.read_new_events)
      * [reset](#snakesee.EventReader.reset)
  + [EventType](#snakesee.EventType)
  + [InvalidProfileError](#snakesee.InvalidProfileError)
  + [JobInfo](#snakesee.JobInfo)

    - [Attributes](#snakesee.JobInfo-attributes)

      * [duration](#snakesee.JobInfo.duration)
      * [elapsed](#snakesee.JobInfo.elapsed)
  + [PluginError](#snakesee.PluginError)
  + [PluginExecutionError](#snakesee.PluginExecutionError)
  + [PluginLoadError](#snakesee.PluginLoadError)
  + [ProfileError](#snakesee.ProfileError)
  + [ProfileNotFoundError](#snakesee.ProfileNotFoundError)
  + [RuleTimingStats](#snakesee.RuleTimingStats)

    - [Attributes](#snakesee.RuleTimingStats-attributes)

      * [coefficient\_of\_variation](#snakesee.RuleTimingStats.coefficient_of_variation)
      * [count](#snakesee.RuleTimingStats.count)
      * [is\_high\_variance](#snakesee.RuleTimingStats.is_high_variance)
      * [max\_duration](#snakesee.RuleTimingStats.max_duration)
      * [mean\_duration](#snakesee.RuleTimingStats.mean_duration)
      * [median\_input\_size](#snakesee.RuleTimingStats.median_input_size)
      * [min\_duration](#snakesee.RuleTimingStats.min_duration)
      * [std\_dev](#snakesee.RuleTimingStats.std_dev)
    - [Functions](#snakesee.RuleTimingStats-functions)

      * [recency\_factor](#snakesee.RuleTimingStats.recency_factor)
      * [recent\_consistency](#snakesee.RuleTimingStats.recent_consistency)
      * [size\_scaled\_estimate](#snakesee.RuleTimingStats.size_scaled_estimate)
      * [weighted\_mean](#snakesee.RuleTimingStats.weighted_mean)
  + [SnakeseeError](#snakesee.SnakeseeError)
  + [SnakeseeEvent](#snakesee.SnakeseeEvent)

    - [Attributes](#snakesee.SnakeseeEvent-attributes)

      * [wildcards\_dict](#snakesee.SnakeseeEvent.wildcards_dict)
    - [Functions](#snakesee.SnakeseeEvent-functions)

      * [from\_json](#snakesee.SnakeseeEvent.from_json)
  + [TimeEstimate](#snakesee.TimeEstimate)

    - [Functions](#snakesee.TimeEstimate-functions)

      * [format\_eta](#snakesee.TimeEstimate.format_eta)
  + [TimeEstimator](#snakesee.TimeEstimator)

    - [Attributes](#snakesee.TimeEstimator-attributes)

      * [rule\_stats](#snakesee.TimeEstimator.rule_stats)
      * [thread\_stats](#snakesee.TimeEstimator.thread_stats)
      * [wildcard\_stats](#snakesee.TimeEstimator.wildcard_stats)
    - [Functions](#snakesee.TimeEstimator-functions)

      * [\_\_init\_\_](#snakesee.TimeEstimator.__init__)
      * [estimate\_remaining](#snakesee.TimeEstimator.estimate_remaining)
      * [get\_estimate\_for\_job](#snakesee.TimeEstimator.get_estimate_for_job)
      * [global\_mean\_duration](#snakesee.TimeEstimator.global_mean_duration)
      * [load\_from\_events](#snakesee.TimeEstimator.load_from_events)
      * [load\_from\_metadata](#snakesee.TimeEstimator.load_from_metadata)
  + [WorkflowError](#snakesee.WorkflowError)
  + [WorkflowNotFoundError](#snakesee.WorkflowNotFoundError)
  + [WorkflowParseError](#snakesee.WorkflowParseError)
  + [WorkflowProgress](#snakesee.WorkflowProgress)

    - [Attributes](#snakesee.WorkflowProgress-attributes)

      * [elapsed\_seconds](#snakesee.WorkflowProgress.elapsed_seconds)
      * [pending\_jobs](#snakesee.WorkflowProgress.pending_jobs)
      * [percent\_complete](#snakesee.WorkflowProgress.percent_complete)
  + [WorkflowStatus](#snakesee.WorkflowStatus)
* [Functions](#snakesee-functions)

  + [format\_duration](#snakesee.format_duration)
  + [get\_event\_file\_path](#snakesee.get_event_file_path)
  + [parse\_workflow\_state](#snakesee.parse_workflow_state)
* [Modules](#snakesee-modules)

  + [cli](#snakesee.cli)

    - [Classes](#snakesee.cli-classes)
    - [Functions](#snakesee.cli-functions)

      * [log\_handler\_path](#snakesee.cli.log_handler_path)
      * [main](#snakesee.cli.main)
      * [profile\_export](#snakesee.cli.profile_export)
      * [profile\_show](#snakesee.cli.profile_show)
      * [status](#snakesee.cli.status)
      * [watch](#snakesee.cli.watch)
  + [constants](#snakesee.constants)

    - [Classes](#snakesee.constants-classes)

      * [CacheConfig](#snakesee.constants.CacheConfig)
      * [FileSizeLimits](#snakesee.constants.FileSizeLimits)
      * [RefreshRateConfig](#snakesee.constants.RefreshRateConfig)
  + [estimation](#snakesee.estimation)

    - [Classes](#snakesee.estimation-classes)

      * [HistoricalDataLoader](#snakesee.estimation.HistoricalDataLoader)

        + [Functions](#snakesee.estimation.HistoricalDataLoader-functions)
      * [PendingRuleInferrer](#snakesee.estimation.PendingRuleInferrer)

        + [Functions](#snakesee.estimation.PendingRuleInferrer-functions)
      * [RuleMatchingEngine](#snakesee.estimation.RuleMatchingEngine)

        + [Functions](#snakesee.estimation.RuleMatchingEngine-functions)
      * [TimeEstimator](#snakesee.estimation.TimeEstimator)

        + [Attributes](#snakesee.estimation.TimeEstimator-attributes)
        + [Functions](#snakesee.estimation.TimeEstimator-functions)
    - [Functions](#snakesee.estimation-functions)

      * [levenshtein\_distance](#snakesee.estimation.levenshtein_distance)
    - [Modules](#snakesee.estimation-modules)

      * [data\_loader](#snakesee.estimation.data_loader)

        + [Classes](#snakesee.estimation.data_loader-classes)
        + [Functions](#snakesee.estimation.data_loader-functions)
      * [estimator](#snakesee.estimation.estimator)

        + [Classes](#snakesee.estimation.estimator-classes)
        + [Functions](#snakesee.estimation.estimator-functions)
      * [pending\_inferrer](#snakesee.estimation.pending_inferrer)

        + [Classes](#snakesee.estimation.pending_inferrer-classes)
      * [rule\_matcher](#snakesee.estimation.rule_matcher)

        + [Classes](#snakesee.estimation.rule_matcher-classes)
        + [Functions](#snakesee.estimation.rule_matcher-functions)
  + [estimator](#snakesee.estimator)

    - [Classes](#snakesee.estimator-classes)

      * [TimeEstimator](#snakesee.estimator.TimeEstimator)

        + [Attributes](#snakesee.estimator.TimeEstimator-attributes)
        + [Functions](#snakesee.estimator.TimeEstimator-functions)
  + [events](#snakesee.events)

    - [Classes](#snakesee.events-classes)

      * [EventReader](#snakesee.events.EventReader)

        + [Attributes](#snakesee.events.EventReader-attributes)
        + [Functions](#snakesee.events.EventReader-functions)
      * [EventType](#snakesee.events.EventType)
      * [SnakeseeEvent](#snakesee.events.SnakeseeEvent)

        + [Attributes](#snakesee.events.SnakeseeEvent-attributes)
        + [Functions](#snakesee.events.SnakeseeEvent-functions)
    - [Functions](#snakesee.events-functions)

      * [get\_event\_file\_path](#snakesee.events.get_event_file_path)
  + [exceptions](#snakesee.exceptions)

    - [Classes](#snakesee.exceptions-classes)

      * [ClockSkewError](#snakesee.exceptions.ClockSkewError)
      * [ConfigurationError](#snakesee.exceptions.ConfigurationError)
      * [EventWriteError](#snakesee.exceptions.EventWriteError)
      * [InvalidDurationError](#snakesee.exceptions.InvalidDurationError)
      * [InvalidParameterError](#snakesee.exceptions.InvalidParameterError)
      * [InvalidProfileError](#snakesee.exceptions.InvalidProfileError)
      * [LogParsingError](#snakesee.exceptions.LogParsingError)
      * [MetadataParsingError](#snakesee.exceptions.MetadataParsingError)
      * [ParsingError](#snakesee.exceptions.ParsingError)
      * [PluginError](#snakesee.exceptions.PluginError)
      * [PluginExecutionError](#snakesee.exceptions.PluginExecutionError)
      * [PluginLoadError](#snakesee.exceptions.PluginLoadError)
      * [ProfileError](#snakesee.exceptions.ProfileError)
      * [ProfileNotFoundError](#snakesee.exceptions.ProfileNotFoundError)
      * [SnakeseeError](#snakesee.exceptions.SnakeseeError)
      * [ValidationError](#snakesee.exceptions.ValidationError)
      * [WorkflowError](#snakesee.exceptions.WorkflowError)
      * [WorkflowNotFoundError](#snakesee.exceptions.WorkflowNotFoundError)
      * [WorkflowParseError](#snakesee.exceptions.WorkflowParseError)
  + [formatting](#snakesee.formatting)

    - [Classes](#snakesee.formatting-classes)

      * [StatusColor](#snakesee.formatting.StatusColor)
      * [StatusStyle](#snakesee.formatting.StatusStyle)

        + [Attributes](#snakesee.formatting.StatusStyle-attributes)
    - [Functions](#snakesee.formatting-functions)

      * [format\_count](#snakesee.formatting.format_count)
      * [format\_count\_compact](#snakesee.formatting.format_count_compact)
      * [format\_duration](#snakesee.formatting.format_duration)
      * [format\_duration\_range](#snakesee.formatting.format_duration_range)
      * [format\_eta](#snakesee.formatting.format_eta)
      * [format\_percentage](#snakesee.formatting.format_percentage)
      * [format\_size](#snakesee.formatting.format_size)
      * [format\_size\_rate](#snakesee.formatting.format_size_rate)
      * [format\_wildcards](#snakesee.formatting.format_wildcards)
      * [get\_status\_color](#snakesee.formatting.get_status_color)
      * [get\_status\_style](#snakesee.formatting.get_status_style)
  + [log\_handler\_script](#snakesee.log_handler_script)

    - [Functions](#snakesee.log_handler_script-functions)

      * [log\_handler](#snakesee.log_handler_script.log_handler)
  + [logging](#snakesee.logging)

    - [Basic configuration](#snakesee.logging--basic-configuration)
    - [JSON output for log aggregation](#snakesee.logging--json-output-for-log-aggregation)
    - [Classes](#snakesee.logging-classes)

      * [ColoredFormatter](#snakesee.logging.ColoredFormatter)

        + [Functions](#snakesee.logging.ColoredFormatter-functions)
      * [StructuredFormatter](#snakesee.logging.StructuredFormatter)

        + [Functions](#snakesee.logging.StructuredFormatter-functions)
    - [Functions](#snakesee.logging-functions)

      * [configure\_logging](#snakesee.logging.configure_logging)
      * [get\_logger](#snakesee.logging.get_logger)
  + [models](#snakesee.models)

    - [Classes](#snakesee.models-classes)

      * [JobInfo](#snakesee.models.JobInfo)

        + [Attributes](#snakesee.models.JobInfo-attributes)
      * [RuleTimingStats](#snakesee.models.RuleTimingStats)

        + [Attributes](#snakesee.models.RuleTimingStats-attributes)
        + [Functions](#snakesee.models.RuleTimingStats-functions)
      * [ThreadTimingStats](#snakesee.models.ThreadTimingStats)

        + [Functions](#snakesee.models.ThreadTimingStats-functions)
      * [TimeEstimate](#snakesee.models.TimeEstimate)

        + [Functions](#snakesee.models.TimeEstimate-functions)
      * [WildcardTimingStats](#snakesee.models.WildcardTimingStats)

        + [Functions](#snakesee.models.WildcardTimingStats-functions)
      * [WorkflowProgress](#snakesee.models.WorkflowProgress)

        + [Attributes](#snakesee.models.WorkflowProgress-attributes)
      * [WorkflowStatus](#snakesee.models.WorkflowStatus)
    - [Functions](#snakesee.models-functions)

      * [format\_duration](#snakesee.models.format_duration)
  + [parameter\_validation](#snakesee.parameter_validation)

    - [Classes](#snakesee.parameter_validation-classes)
    - [Functions](#snakesee.parameter_validation-functions)

      * [require\_in\_range](#snakesee.parameter_validation.require_in_range)
      * [require\_non\_negative](#snakesee.parameter_validation.require_non_negative)
      * [require\_not\_empty](#snakesee.parameter_validation.require_not_empty)
      * [require\_positive](#snakesee.parameter_validation.require_positive)
      * [validate\_in\_range](#snakesee.parameter_validation.validate_in_range)
      * [validate\_non\_negative](#snakesee.parameter_validation.validate_non_negative)
      * [validate\_not\_empty](#snakesee.parameter_validation.validate_not_empty)
      * [validate\_positive](#snakesee.parameter_validation.validate_positive)
  + [parser](#snakesee.parser)

    - [Classes](#snakesee.parser-classes)

      * [FailureT