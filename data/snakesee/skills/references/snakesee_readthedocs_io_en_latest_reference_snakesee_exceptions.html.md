[ ]
[ ]

[Skip to content](#snakesee.exceptions)

snakesee

exceptions

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
    - [ ]

      exceptions

      [exceptions](exceptions.html)

      Table of contents
      * [exceptions](#snakesee.exceptions)
      * [Classes](#snakesee.exceptions-classes)

        + [ClockSkewError](#snakesee.exceptions.ClockSkewError)
        + [ConfigurationError](#snakesee.exceptions.ConfigurationError)
        + [EventWriteError](#snakesee.exceptions.EventWriteError)
        + [InvalidDurationError](#snakesee.exceptions.InvalidDurationError)
        + [InvalidParameterError](#snakesee.exceptions.InvalidParameterError)
        + [InvalidProfileError](#snakesee.exceptions.InvalidProfileError)
        + [LogParsingError](#snakesee.exceptions.LogParsingError)
        + [MetadataParsingError](#snakesee.exceptions.MetadataParsingError)
        + [ParsingError](#snakesee.exceptions.ParsingError)
        + [PluginError](#snakesee.exceptions.PluginError)
        + [PluginExecutionError](#snakesee.exceptions.PluginExecutionError)
        + [PluginLoadError](#snakesee.exceptions.PluginLoadError)
        + [ProfileError](#snakesee.exceptions.ProfileError)
        + [ProfileNotFoundError](#snakesee.exceptions.ProfileNotFoundError)
        + [SnakeseeError](#snakesee.exceptions.SnakeseeError)
        + [ValidationError](#snakesee.exceptions.ValidationError)
        + [WorkflowError](#snakesee.exceptions.WorkflowError)
        + [WorkflowNotFoundError](#snakesee.exceptions.WorkflowNotFoundError)
        + [WorkflowParseError](#snakesee.exceptions.WorkflowParseError)
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

* [exceptions](#snakesee.exceptions)
* [Classes](#snakesee.exceptions-classes)

  + [ClockSkewError](#snakesee.exceptions.ClockSkewError)
  + [ConfigurationError](#snakesee.exceptions.ConfigurationError)
  + [EventWriteError](#snakesee.exceptions.EventWriteError)
  + [InvalidDurationError](#snakesee.exceptions.InvalidDurationError)
  + [InvalidParameterError](#snakesee.exceptions.InvalidParameterError)
  + [InvalidProfileError](#snakesee.exceptions.InvalidProfileError)
  + [LogParsingError](#snakesee.exceptions.LogParsingError)
  + [MetadataParsingError](#snakesee.exceptions.MetadataParsingError)
  + [ParsingError](#snakesee.exceptions.ParsingError)
  + [PluginError](#snakesee.exceptions.PluginError)
  + [PluginExecutionError](#snakesee.exceptions.PluginExecutionError)
  + [PluginLoadError](#snakesee.exceptions.PluginLoadError)
  + [ProfileError](#snakesee.exceptions.ProfileError)
  + [ProfileNotFoundError](#snakesee.exceptions.ProfileNotFoundError)
  + [SnakeseeError](#snakesee.exceptions.SnakeseeError)
  + [ValidationError](#snakesee.exceptions.ValidationError)
  + [WorkflowError](#snakesee.exceptions.WorkflowError)
  + [WorkflowNotFoundError](#snakesee.exceptions.WorkflowNotFoundError)
  + [WorkflowParseError](#snakesee.exceptions.WorkflowParseError)

# exceptions

Application-specific exceptions for snakesee.

This module provides a hierarchy of exceptions that enable more precise
error handling throughout the application. Using specific exception types
allows callers to catch and handle different error conditions appropriately.

Exception Hierarchy

SnakeseeError (base)
├── WorkflowError
│ ├── WorkflowNotFoundError
│ └── WorkflowParseError
├── ProfileError
│ ├── ProfileNotFoundError
│ └── InvalidProfileError
├── PluginError
│ ├── PluginLoadError
│ └── PluginExecutionError
├── ConfigurationError
├── ParsingError
│ ├── LogParsingError
│ └── MetadataParsingError
├── ValidationError
│ ├── InvalidDurationError
│ ├── ClockSkewError
│ └── InvalidParameterError
└── EventWriteError

## Classes[¶](#snakesee.exceptions-classes "Permanent link")

### ClockSkewError [¶](#snakesee.exceptions.ClockSkewError "Permanent link")

Bases: `[ValidationError](index.html#snakesee.exceptions.ValidationError "ValidationError (snakesee.exceptions.ValidationError)")`

Raised when clock skew is detected (negative duration).

This typically occurs when system time has been adjusted between
recording start\_time and end\_time for a job.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `start_time` |  | The recorded start time. |
| `end_time` |  | The recorded end time. |
| `context` |  | Description of where the error occurred. |
| `message` |  | Human-readable error description. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 ``` | ``` class ClockSkewError(ValidationError):     """Raised when clock skew is detected (negative duration).      This typically occurs when system time has been adjusted between     recording start_time and end_time for a job.      Attributes:         start_time: The recorded start time.         end_time: The recorded end time.         context: Description of where the error occurred.         message: Human-readable error description.     """      def __init__(         self,         start_time: float,         end_time: float,         context: str | None = None,         message: str | None = None,     ) -> None:         self.start_time = start_time         self.end_time = end_time         self.context = context         ctx = f" for {context}" if context else ""         diff = end_time - start_time         self.message = (             message             or f"Clock skew detected{ctx}: end_time ({end_time:.2f}) < "             f"start_time ({start_time:.2f}), diff={diff:.2f}s"         )         super().__init__(self.message) ``` |

### ConfigurationError [¶](#snakesee.exceptions.ConfigurationError "Permanent link")

Bases: `[SnakeseeError](index.html#snakesee.exceptions.SnakeseeError "SnakeseeError (snakesee.exceptions.SnakeseeError)")`

Raised when there is a configuration error.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `parameter` |  | The configuration parameter that is invalid. |
| `message` |  | Human-readable error description. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 172 173 174 175 176 177 178 179 180 181 182 183 ``` | ``` class ConfigurationError(SnakeseeError):     """Raised when there is a configuration error.      Attributes:         parameter: The configuration parameter that is invalid.         message: Human-readable error description.     """      def __init__(self, parameter: str, message: str | None = None) -> None:         self.parameter = parameter         self.message = message or f"Invalid configuration for '{parameter}'"         super().__init__(self.message) ``` |

### EventWriteError [¶](#snakesee.exceptions.EventWriteError "Permanent link")

Bases: `[SnakeseeError](index.html#snakesee.exceptions.SnakeseeError "SnakeseeError (snakesee.exceptions.SnakeseeError)")`

Raised when writing events fails.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `path` |  | The event file path. |
| `message` |  | Human-readable error description. |
| `cause` |  | The underlying exception, if any. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 ``` | ``` class EventWriteError(SnakeseeError):     """Raised when writing events fails.      Attributes:         path: The event file path.         message: Human-readable error description.         cause: The underlying exception, if any.     """      def __init__(         self,         path: Path,         message: str | None = None,         cause: Exception | None = None,     ) -> None:         self.path = path         self.cause = cause         self.message = message or f"Failed to write event to {path}"         if cause:             self.message = f"{self.message}: {cause}"         super().__init__(self.message) ``` |

### InvalidDurationError [¶](#snakesee.exceptions.InvalidDurationError "Permanent link")

Bases: `[ValidationError](index.html#snakesee.exceptions.ValidationError "ValidationError (snakesee.exceptions.ValidationError)")`

Raised when a duration value is invalid.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `value` |  | The invalid duration value. |
| `context` |  | Description of where the error occurred. |
| `message` |  | Human-readable error description. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 ``` | ``` class InvalidDurationError(ValidationError):     """Raised when a duration value is invalid.      Attributes:         value: The invalid duration value.         context: Description of where the error occurred.         message: Human-readable error description.     """      def __init__(         self,         value: float,         context: str | None = None,         message: str | None = None,     ) -> None:         self.value = value         self.context = context         ctx = f" in {context}" if context else ""         self.message = message or f"Invalid duration{ctx}: {value}"         super().__init__(self.message) ``` |

### InvalidParameterError [¶](#snakesee.exceptions.InvalidParameterError "Permanent link")

Bases: `[ValidationError](index.html#snakesee.exceptions.ValidationError "ValidationError (snakesee.exceptions.ValidationError)")`

Raised when a parameter value is invalid.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `parameter` |  | The parameter name. |
| `value` |  | The invalid value. |
| `constraint` |  | Description of the valid range/constraint. |
| `message` |  | Human-readable error description. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 ``` | ``` class InvalidParameterError(ValidationError):     """Raised when a parameter value is invalid.      Attributes:         parameter: The parameter name.         value: The invalid value.         constraint: Description of the valid range/constraint.         message: Human-readable error description.     """      def __init__(         self,         parameter: str,         value: object,         constraint: str | None = None,         message: str | None = None,     ) -> None:         self.parameter = parameter         self.value = value         self.constraint = constraint         constraint_msg = f" (must be {constraint})" if constraint else ""         self.message = message or f"Invalid value for '{parameter}': {value}{constraint_msg}"         super().__init__(self.message) ``` |

### InvalidProfileError [¶](#snakesee.exceptions.InvalidProfileError "Permanent link")

Bases: `[ProfileError](index.html#snakesee.exceptions.ProfileError "ProfileError (snakesee.exceptions.ProfileError)")`

Raised when a timing profile is invalid or corrupted.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `path` |  | The profile path that was invalid. |
| `message` |  | Human-readable error description. |
| `cause` |  | The underlying exception, if any. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 ``` | ``` class InvalidProfileError(ProfileError):     """Raised when a timing profile is invalid or corrupted.      Attributes:         path: The profile path that was invalid.         message: Human-readable error description.         cause: The underlying exception, if any.     """      def __init__(         self,         path: Path,         message: str | None = None,         cause: Exception | None = None,     ) -> None:         self.path = path         self.cause = cause         self.message = message or f"Invalid profile at {path}"         if cause:             self.message = f"{self.message}: {cause}"         super().__init__(self.message) ``` |

### LogParsingError [¶](#snakesee.exceptions.LogParsingError "Permanent link")

Bases: `[ParsingError](index.html#snakesee.exceptions.ParsingError "ParsingError (snakesee.exceptions.ParsingError)")`

Raised when parsing a log file fails.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `path` |  | The log file path that could not be parsed. |
| `line_number` |  | The line number where the error occurred (if applicable). |
| `message` |  | Human-readable error description. |
| `cause` |  | The underlying exception, if any. |

Source code in `snakesee/exceptions.py`

|  |  |
| --- | --- |
| ``` 190 191 192 193 194 