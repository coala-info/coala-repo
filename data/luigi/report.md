# luigi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| luigi | Failed | image problem: the image ENTRYPOINT is luigid, so 'luigi --module ...' is passed to luigid as arguments (luigid: error: unrecognized arguments: luigi ...) |
| luigi_luigid | Not completed | long-running scheduler server; also the image ENTRYPOINT is already luigid, so the command word luigid is passed to it as an argument |

## luigi

### Tool Description
Run a Luigi workflow task from a Python module with the luigi command line runner.

### Metadata
- **Docker Image**: biocontainers/luigi:phenomenal-v2.6.0_cv0.1.6
- **Homepage**: https://github.com/spotify/luigi
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: luigi [--TestNotificationsTask-raise-in-complete] [--email-force-send]
             [--email-format EMAIL_FORMAT] [--email-method EMAIL_METHOD]
             [--email-prefix EMAIL_PREFIX] [--email-receiver EMAIL_RECEIVER]
             [--email-sender EMAIL_SENDER] [--smtp-host SMTP_HOST]
             [--smtp-local-hostname SMTP_LOCAL_HOSTNAME] [--smtp-no-tls]
             [--smtp-password SMTP_PASSWORD] [--smtp-port SMTP_PORT]
             [--smtp-ssl] [--smtp-timeout SMTP_TIMEOUT]
             [--smtp-username SMTP_USERNAME]
             [--sendgrid-username SENDGRID_USERNAME]
             [--sendgrid-password SENDGRID_PASSWORD]
             [--batch-email-email-interval BATCH_EMAIL_EMAIL_INTERVAL]
             [--batch-email-batch-mode BATCH_EMAIL_BATCH_MODE]
             [--batch-email-error-lines BATCH_EMAIL_ERROR_LINES]
             [--batch-email-error-messages BATCH_EMAIL_ERROR_MESSAGES]
             [--batch-email-group-by-error-messages]
             [--scheduler-retry-delay SCHEDULER_RETRY_DELAY]
             [--scheduler-remove-delay SCHEDULER_REMOVE_DELAY]
             [--scheduler-worker-disconnect-delay SCHEDULER_WORKER_DISCONNECT_DELAY]
             [--scheduler-state-path SCHEDULER_STATE_PATH]
             [--scheduler-batch-emails]
             [--scheduler-disable-window SCHEDULER_DISABLE_WINDOW]
             [--scheduler-retry-count SCHEDULER_RETRY_COUNT]
             [--scheduler-disable-hard-timeout SCHEDULER_DISABLE_HARD_TIMEOUT]
             [--scheduler-disable-persist SCHEDULER_DISABLE_PERSIST]
             [--scheduler-max-shown-tasks SCHEDULER_MAX_SHOWN_TASKS]
             [--scheduler-max-graph-nodes SCHEDULER_MAX_GRAPH_NODES]
             [--scheduler-record-task-history] [--scheduler-prune-on-get-work]
             [--worker-ping-interval WORKER_PING_INTERVAL]
             [--worker-keep-alive] [--worker-count-uniques]
             [--worker-count-last-scheduled]
             [--worker-wait-interval WORKER_WAIT_INTERVAL]
             [--worker-wait-jitter WORKER_WAIT_JITTER]
             [--worker-max-reschedules WORKER_MAX_RESCHEDULES]
             [--worker-timeout WORKER_TIMEOUT]
             [--worker-task-limit WORKER_TASK_LIMIT]
             [--worker-retry-external-tasks] [--worker-send-failure-email]
             [--worker-no-install-shutdown-handler]
             [--execution-summary-summary-length EXECUTION_SUMMARY_SUMMARY_LENGTH]
             [--local-scheduler] [--scheduler-host CORE_SCHEDULER_HOST]
             [--scheduler-port CORE_SCHEDULER_PORT]
             [--scheduler-url CORE_SCHEDULER_URL] [--lock-size CORE_LOCK_SIZE]
             [--no-lock] [--lock-pid-dir CORE_LOCK_PID_DIR] [--take-lock]
             [--workers CORE_WORKERS]
             [--logging-conf-file CORE_LOGGING_CONF_FILE]
             [--log-level CORE_LOG_LEVEL] [--module CORE_MODULE]
             [--parallel-scheduling] [--assistant] [--help] [--help-all]
             [--RangeBase-of RANGEBASE_OF]
             [--RangeBase-of-params RANGEBASE_OF_PARAMS]
             [--RangeBase-start RANGEBASE_START]
             [--RangeBase-stop RANGEBASE_STOP] [--RangeBase-reverse]
             [--RangeBase-task-limit RANGEBASE_TASK_LIMIT]
             [--RangeBase-now RANGEBASE_NOW]
             [--RangeBase-param-name RANGEBASE_PARAM_NAME]
             [--RangeDailyBase-of RANGEDAILYBASE_OF]
             [--RangeDailyBase-of-params RANGEDAILYBASE_OF_PARAMS]
             [--RangeDailyBase-reverse]
             [--RangeDailyBase-task-limit RANGEDAILYBASE_TASK_LIMIT]
             [--RangeDailyBase-now RANGEDAILYBASE_NOW]
             [--RangeDailyBase-param-name RANGEDAILYBASE_PARAM_NAME]
             [--RangeDailyBase-start RANGEDAILYBASE_START]
             [--RangeDailyBase-stop RANGEDAILYBASE_STOP]
             [--RangeDailyBase-days-back RANGEDAILYBASE_DAYS_BACK]
             [--RangeDailyBase-days-forward RANGEDAILYBASE_DAYS_FORWARD]
             [--RangeHourlyBase-of RANGEHOURLYBASE_OF]
             [--RangeHourlyBase-of-params RANGEHOURLYBASE_OF_PARAMS]
             [--RangeHourlyBase-reverse]
             [--RangeHourlyBase-task-limit RANGEHOURLYBASE_TASK_LIMIT]
             [--RangeHourlyBase-now RANGEHOURLYBASE_NOW]
             [--RangeHourlyBase-param-name RANGEHOURLYBASE_PARAM_NAME]
             [--RangeHourlyBase-start RANGEHOURLYBASE_START]
             [--RangeHourlyBase-stop RANGEHOURLYBASE_STOP]
             [--RangeHourlyBase-hours-back RANGEHOURLYBASE_HOURS_BACK]
             [--RangeHourlyBase-hours-forward RANGEHOURLYBASE_HOURS_FORWARD]
             [--RangeByMinutesBase-of RANGEBYMINUTESBASE_OF]
             [--RangeByMinutesBase-of-params RANGEBYMINUTESBASE_OF_PARAMS]
             [--RangeByMinutesBase-reverse]
             [--RangeByMinutesBase-task-limit RANGEBYMINUTESBASE_TASK_LIMIT]
             [--RangeByMinutesBase-now RANGEBYMINUTESBASE_NOW]
             [--RangeByMinutesBase-param-name RANGEBYMINUTESBASE_PARAM_NAME]
             [--RangeByMinutesBase-start RANGEBYMINUTESBASE_START]
             [--RangeByMinutesBase-stop RANGEBYMINUTESBASE_STOP]
             [--RangeByMinutesBase-minutes-back RANGEBYMINUTESBASE_MINUTES_BACK]
             [--RangeByMinutesBase-minutes-forward RANGEBYMINUTESBASE_MINUTES_FORWARD]
             [--RangeByMinutesBase-minutes-interval RANGEBYMINUTESBASE_MINUTES_INTERVAL]
             [--RangeDaily-of RANGEDAILY_OF]
             [--RangeDaily-of-params RANGEDAILY_OF_PARAMS]
             [--RangeDaily-reverse]
             [--RangeDaily-task-limit RANGEDAILY_TASK_LIMIT]
             [--RangeDaily-now RANGEDAILY_NOW]
             [--RangeDaily-param-name RANGEDAILY_PARAM_NAME]
             [--RangeDaily-start RANGEDAILY_START]
             [--RangeDaily-stop RANGEDAILY_STOP]
             [--RangeDaily-days-back RANGEDAILY_DAYS_BACK]
             [--RangeDaily-days-forward RANGEDAILY_DAYS_FORWARD]
             [--RangeHourly-of RANGEHOURLY_OF]
             [--RangeHourly-of-params RANGEHOURLY_OF_PARAMS]
             [--RangeHourly-reverse]
             [--RangeHourly-task-limit RANGEHOURLY_TASK_LIMIT]
             [--RangeHourly-now RANGEHOURLY_NOW]
             [--RangeHourly-param-name RANGEHOURLY_PARAM_NAME]
             [--RangeHourly-start RANGEHOURLY_START]
             [--RangeHourly-stop RANGEHOURLY_STOP]
             [--RangeHourly-hours-back RANGEHOURLY_HOURS_BACK]
             [--RangeHourly-hours-forward RANGEHOURLY_HOURS_FORWARD]
             [--RangeByMinutes-of RANGEBYMINUTES_OF]
             [--RangeByMinutes-of-params RANGEBYMINUTES_OF_PARAMS]
             [--RangeByMinutes-reverse]
             [--RangeByMinutes-task-limit RANGEBYMINUTES_TASK_LIMIT]
             [--RangeByMinutes-now RANGEBYMINUTES_NOW]
             [--RangeByMinutes-param-name RANGEBYMINUTES_PARAM_NAME]
             [--RangeByMinutes-start RANGEBYMINUTES_START]
             [--RangeByMinutes-stop RANGEBYMINUTES_STOP]
             [--RangeByMinutes-minutes-back RANGEBYMINUTES_MINUTES_BACK]
             [--RangeByMinutes-minutes-forward RANGEBYMINUTES_MINUTES_FORWARD]
             [--RangeByMinutes-minutes-interval RANGEBYMINUTES_MINUTES_INTERVAL]
             [--retcode-unhandled-exception RETCODE_UNHANDLED_EXCEPTION]
             [--retcode-missing-data RETCODE_MISSING_DATA]
             [--retcode-task-failed RETCODE_TASK_FAILED]
             [--retcode-already-running RETCODE_ALREADY_RUNNING]
             [--retcode-scheduling-error RETCODE_SCHEDULING_ERROR]
             [--retcode-not-run RETCODE_NOT_RUN]
             [Required root task]

positional arguments:
  Required root task    Task family to run. Is not optional.

optional arguments:
  --TestNotificationsTask-raise-in-complete
                        If true, fail in complete() instead of run()
  --email-force-send    Send e-mail even from a tty
```

## luigi_luigid

### Tool Description
Central luigi server (long-running scheduler daemon)

### Metadata
- **Docker Image**: biocontainers/luigi:phenomenal-v2.6.0_cv0.1.6
- **Homepage**: https://github.com/spotify/luigi
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: luigid [-h] [--background] [--pidfile PIDFILE] [--logdir LOGDIR]
              [--state-path STATE_PATH] [--address ADDRESS]
              [--unix-socket UNIX_SOCKET] [--port PORT]

Central luigi server

optional arguments:
  -h, --help            show this help message and exit
  --background          Run in background mode
  --pidfile PIDFILE     Write pidfile
  --logdir LOGDIR       log directory
  --state-path STATE_PATH
                        Pickled state file
  --address ADDRESS     Listening interface
  --unix-socket UNIX_SOCKET
                        Unix socket path
  --port PORT           Listening port
```

