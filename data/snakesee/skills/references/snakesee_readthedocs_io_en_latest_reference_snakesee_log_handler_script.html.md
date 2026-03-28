[ ]
[ ]

[Skip to content](#snakesee.log_handler_script)

snakesee

log\_handler\_script

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
    - [ ]

      log\_handler\_script

      [log\_handler\_script](log_handler_script.html)

      Table of contents
      * [log\_handler\_script](#snakesee.log_handler_script)
      * [Functions](#snakesee.log_handler_script-functions)

        + [log\_handler](#snakesee.log_handler_script.log_handler)
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

* [log\_handler\_script](#snakesee.log_handler_script)
* [Functions](#snakesee.log_handler_script-functions)

  + [log\_handler](#snakesee.log_handler_script.log_handler)

# log\_handler\_script

Log handler script for Snakemake 8.x --log-handler-script integration.

This script converts Snakemake log messages to the same event format used by
the snakesee logger plugin (Snakemake 9+), enabling real-time monitoring
with snakesee for Snakemake 8.x users.

Usage

snakemake --log-handler-script $(snakesee log-handler-path) --cores 4

Note on execution tracking

This script is optimized for local execution where jobs start immediately
after submission. For cluster/cloud executors (SLURM, AWS Batch, etc.),
jobs may be queued before running. Since Snakemake 8.x doesn't provide a
reliable signal for when a queued job actually starts executing, we emit
job\_started immediately upon job\_info. This means "running" jobs may
actually still be queued on cluster systems.

For accurate queue vs running tracking on clusters, consider using
Snakemake 9+ with the logger plugin (--logger snakesee).

## Functions[¶](#snakesee.log_handler_script-functions "Permanent link")

### log\_handler [¶](#snakesee.log_handler_script.log_handler "Permanent link")

```
log_handler(msg: dict[str, Any]) -> None
```

Main log handler function called by Snakemake for every log message.

This function is invoked by Snakemake when using --log-handler-script.
It converts log messages to snakesee events for real-time monitoring.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `msg` | `dict[str, Any]` | Dictionary containing log message data with keys like: - level: Log level (job\_info, job\_finished, error, progress, etc.) - jobid: Job identifier - name/rule: Rule name - wildcards: Job wildcards - threads: Thread count - resources: Resource requirements - input/output: File lists - done/total: Progress counts | *required* |

Source code in `snakesee/log_handler_script.py`

|  |  |
| --- | --- |
| ``` 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 ``` | ``` def log_handler(msg: dict[str, Any]) -> None:     """Main log handler function called by Snakemake for every log message.      This function is invoked by Snakemake when using --log-handler-script.     It converts log messages to snakesee events for real-time monitoring.      Args:         msg: Dictionary containing log message data with keys like:             - level: Log level (job_info, job_finished, error, progress, etc.)             - jobid: Job identifier             - name/rule: Rule name             - wildcards: Job wildcards             - threads: Thread count             - resources: Resource requirements             - input/output: File lists             - done/total: Progress counts     """     level = msg.get("level")     if level is None:         return      timestamp = time.time()      # Emit workflow_started on first message     _ensure_workflow_started(timestamp)      # Map log levels to event handlers     if level == "job_info":         _handle_job_info(msg, timestamp)     elif level == "job_started":         _handle_job_started(msg, timestamp)     elif level == "job_finished":         _handle_job_finished(msg, timestamp)     elif level in ("job_error", "error"):         _handle_job_error(msg, timestamp)     elif level == "progress":         _handle_progress(msg, timestamp) ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)