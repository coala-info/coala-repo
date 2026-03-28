[ ]
[ ]

[Skip to content](#snakesee.logging)

snakesee

logging

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
    - [ ]

      logging

      [logging](logging.html)

      Table of contents
      * [logging](#snakesee.logging)
      * [Basic configuration](#snakesee.logging--basic-configuration)
      * [JSON output for log aggregation](#snakesee.logging--json-output-for-log-aggregation)
      * [Classes](#snakesee.logging-classes)

        + [ColoredFormatter](#snakesee.logging.ColoredFormatter)

          - [Functions](#snakesee.logging.ColoredFormatter-functions)

            * [format](#snakesee.logging.ColoredFormatter.format)
        + [StructuredFormatter](#snakesee.logging.StructuredFormatter)

          - [Functions](#snakesee.logging.StructuredFormatter-functions)

            * [format](#snakesee.logging.StructuredFormatter.format)
      * [Functions](#snakesee.logging-functions)

        + [configure\_logging](#snakesee.logging.configure_logging)
        + [get\_logger](#snakesee.logging.get_logger)
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

* [logging](#snakesee.logging)
* [Basic configuration](#snakesee.logging--basic-configuration)
* [JSON output for log aggregation](#snakesee.logging--json-output-for-log-aggregation)
* [Classes](#snakesee.logging-classes)

  + [ColoredFormatter](#snakesee.logging.ColoredFormatter)

    - [Functions](#snakesee.logging.ColoredFormatter-functions)

      * [format](#snakesee.logging.ColoredFormatter.format)
  + [StructuredFormatter](#snakesee.logging.StructuredFormatter)

    - [Functions](#snakesee.logging.StructuredFormatter-functions)

      * [format](#snakesee.logging.StructuredFormatter.format)
* [Functions](#snakesee.logging-functions)

  + [configure\_logging](#snakesee.logging.configure_logging)
  + [get\_logger](#snakesee.logging.get_logger)

# logging

Logging configuration for snakesee.

This module provides centralized logging configuration with support for
both human-readable and structured (JSON) output formats.

Usage

from snakesee.logging import configure\_logging

## Basic configuration[¶](#snakesee.logging--basic-configuration "Permanent link")

configure\_logging(level="INFO")

## JSON output for log aggregation[¶](#snakesee.logging--json-output-for-log-aggregation "Permanent link")

configure\_logging(level="DEBUG", json\_output=True)

## Classes[¶](#snakesee.logging-classes "Permanent link")

### ColoredFormatter [¶](#snakesee.logging.ColoredFormatter "Permanent link")

Bases: `Formatter`

Colored formatter for human-readable console output.

Source code in `snakesee/logging.py`

|  |  |
| --- | --- |
| ``` 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 ``` | ``` class ColoredFormatter(logging.Formatter):     """Colored formatter for human-readable console output."""      COLORS: ClassVar[dict[str, str]] = {         "DEBUG": "\033[36m",  # Cyan         "INFO": "\033[32m",  # Green         "WARNING": "\033[33m",  # Yellow         "ERROR": "\033[31m",  # Red         "CRITICAL": "\033[35m",  # Magenta     }     RESET: ClassVar[str] = "\033[0m"      def __init__(self, fmt: str | None = None, use_color: bool = True) -> None:         super().__init__(fmt)         self.use_color = use_color      def format(self, record: logging.LogRecord) -> str:         """Format a log record with optional color."""         if self.use_color and record.levelname in self.COLORS:             levelname = f"{self.COLORS[record.levelname]}{record.levelname}{self.RESET}"             record = logging.makeLogRecord(record.__dict__)             record.levelname = levelname         return super().format(record) ``` |

#### Functions[¶](#snakesee.logging.ColoredFormatter-functions "Permanent link")

##### format [¶](#snakesee.logging.ColoredFormatter.format "Permanent link")

```
format(record: LogRecord) -> str
```

Format a log record with optional color.

Source code in `snakesee/logging.py`

|  |  |
| --- | --- |
| ``` 112 113 114 115 116 117 118 ``` | ``` def format(self, record: logging.LogRecord) -> str:     """Format a log record with optional color."""     if self.use_color and record.levelname in self.COLORS:         levelname = f"{self.COLORS[record.levelname]}{record.levelname}{self.RESET}"         record = logging.makeLogRecord(record.__dict__)         record.levelname = levelname     return super().format(record) ``` |

### StructuredFormatter [¶](#snakesee.logging.StructuredFormatter "Permanent link")

Bases: `Formatter`

JSON formatter for structured log output.

Produces JSON lines suitable for log aggregation systems like
Elasticsearch, Splunk, or CloudWatch.

Each log entry includes:
- timestamp: ISO 8601 format with timezone
- level: Log level name
- logger: Logger name
- message: Log message
- Additional fields from the record's extra dict

Source code in `snakesee/logging.py`

|  |  |
| --- | --- |
| ``` 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 ``` | ``` class StructuredFormatter(logging.Formatter):     """JSON formatter for structured log output.      Produces JSON lines suitable for log aggregation systems like     Elasticsearch, Splunk, or CloudWatch.      Each log entry includes:     - timestamp: ISO 8601 format with timezone     - level: Log level name     - logger: Logger name     - message: Log message     - Additional fields from the record's extra dict     """      def format(self, record: logging.LogRecord) -> str:         """Format a log record as JSON."""         log_entry: dict[str, object] = {             "timestamp": datetime.fromtimestamp(record.created, tz=timezone.utc).isoformat(),             "level": record.levelname,             "logger": record.name,             "message": record.getMessage(),         }          # Add location info if available         if record.pathname and record.lineno:             log_entry["location"] = {                 "file": record.pathname,                 "line": record.lineno,                 "function": record.funcName,             }          # Add exception info if present         if record.exc_info:             log_entry["exception"] = self.formatException(record.exc_info)          # Add any extra fields         extra_fields = {             key: value             for key, value in record.__dict__.items()             if key             not in {                 "name",                 "msg",                 "args",                 "created",                 "filename",                 "funcName",                 "levelname",                 "levelno",                 "lineno",                 "module",                 "msecs",                 "pathname",                 "process",                 "processName",                 "relativeCreated",                 "stack_info",                 "exc_info",                 "exc_text",                 "thread",                 "threadName",                 "taskName",                 "message",             }         }         if extra_fields:             log_entry["extra"] = extra_fields          return json.dumps(log_entry, default=str) ``` |

#### Functions[¶](#snakesee.logging.StructuredFormatter-functions "Permanent link")

##### format [¶](#snakesee.logging.StructuredFormatter.format "Permanent link")

```
format(record: LogRecord) -> str
```

Format a log record as JSON.

Source code in `snakesee/logging.py`

|  |  |
| --- | --- |
| ``` 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 ``` | ``` def format(self, record: logging.LogRecord) -> str:     """Format a log record as JSON."""     log_entry: dict[str, object] = {         "timestamp": datetime.fromtimestamp(record.created, tz=timezone.utc).isoformat(),         "level": record.levelname,         "logger": record.name,         "message": record.getMessage(),     }      # Add location info if available     if record.pathname and record.lineno:         log_entry["location"] = {             "file": record.pathname,             "line": record.lineno,             "function": record.funcName,         }      # Add exception info if present     if record.exc_info:         log_entry["exception"] = self.formatException(record.exc_info)      # Add any extra fields     extra_fields = {         key: value         for key, value in record.__dict__.items()         if key         not in {             "name",             "msg",             "args",             "created",             "filename",             "funcName",             "levelname",             "levelno",             "lineno",             "module",             "msecs",             "pathname",             "process",             "processName",             "relativeCreated",             "stack_info",             "exc_info",             "exc_text",             "thread",             "threadName",             "taskName",             "message",         }     }     if extra_fields:         log_entry["extra"] = extra_fields      return json.dumps(log_entry, default=str) ``` |

## Functions[¶](#snakesee.logging-functions "Permanent link")

### configure\_logging [¶](#snakesee.logging.configure_logging "Permanent link")

```
configure_logging(level: str | int = 'WARNING', json_output: bool = False, stream: TextIO | None = None, include_timestamp: bool = True) -> None
```

Configure logging for snakesee.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `level` | `str | int` | Log level (DEBUG, INFO, WARNING, ERROR, CRITICAL or int). | `'WARNING'` |
| `json_output` | `bool` | If True, output structured JSON logs. | `False` |
| `stream` | `TextIO | None` | Output stream. Defaults to stderr. | `None` |
| `include_timestamp` | `bool` | Include timestamp in human-readable output. | `True` |

Source code in `snakesee/logging.py`

|  |  |
| --- | --- |
| ``` 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 ``` | ``` def configure_logging(     level: str | int = "WARNING",     json_output: bool = False,     stream: TextIO | None = None,     include_timestamp: bool = True, ) -> None:     """     Configure logging for snakesee.      Args:         level: Log level (DEBUG, INFO, WARNING, ERROR, CRITICAL or int).         json_output: If True, output structured JSON logs.         stream: Output stream. Defaults to stderr.         include_timestamp: Include timestamp in human-readable output.     """     if stream is None:         stream = sys.stderr      # Convert string level to int if needed     if isinstance(level, str):         numeric_level = getattr(logging, level.upper(), None)         if numeric_level is None:             logging.warning("Invalid log level '%s', defaulting to WARNING", level)             numeric_level = logging.WARNING         level = numeric_level      # Get the root snakesee logger     logger = logging.getLogger("snakesee")     logger.setLevel(level)      # Remove existing handlers     logger.handlers.clear()      # Create handler     handler = logging.StreamHandler(stream)     handler.setLevel(level)      # Set formatter     if json_output:         handler.setFormatter(StructuredFormatter())     else:         fmt_parts = []         if include_timestamp:             fmt_parts.append("%(asctime)s")         fmt_parts.extend(["%(levelname)s", "%(name)s", "%(message)s"])         fmt = " - ".join(fmt_parts)          use_color = hasattr(stream, "isatty") and stream.isatty()         handler.setFormatter(ColoredFormatter(fmt, use_color=use_color))      logger.addHandler(handler)      # Don't propagate to root logger     logger.propagate = False ``` |

### get\_logger [¶](#snakesee.logging.get_logger "Permanent link")

```
get_logger(name: str) -> Logger
```

Get a logger for a snakesee module.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `name` | `str` | Module name (will be prefixed with 'snakesee.'). | *required* |

Returns:

| Type | Description |
| --- | --- |
| `Logger` | Logger instance. |

Example

logger = get\_logger(**name**)
logger.info("Processing file", extra={"file": path})

Source code in `snakesee/logging.py`

|  |  |
| --- | --- |
| ``` 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 ``` | ``` 