[ ]
[ ]

[Skip to content](#snakesee.formatting)

snakesee

formatting

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
    - [ ]

      formatting

      [formatting](formatting.html)

      Table of contents
      * [formatting](#snakesee.formatting)
      * [Classes](#snakesee.formatting-classes)

        + [StatusColor](#snakesee.formatting.StatusColor)
        + [StatusStyle](#snakesee.formatting.StatusStyle)

          - [Attributes](#snakesee.formatting.StatusStyle-attributes)

            * [rich\_style](#snakesee.formatting.StatusStyle.rich_style)
      * [Functions](#snakesee.formatting-functions)

        + [format\_count](#snakesee.formatting.format_count)
        + [format\_count\_compact](#snakesee.formatting.format_count_compact)
        + [format\_duration](#snakesee.formatting.format_duration)
        + [format\_duration\_range](#snakesee.formatting.format_duration_range)
        + [format\_eta](#snakesee.formatting.format_eta)
        + [format\_percentage](#snakesee.formatting.format_percentage)
        + [format\_size](#snakesee.formatting.format_size)
        + [format\_size\_rate](#snakesee.formatting.format_size_rate)
        + [format\_wildcards](#snakesee.formatting.format_wildcards)
        + [get\_status\_color](#snakesee.formatting.get_status_color)
        + [get\_status\_style](#snakesee.formatting.get_status_style)
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

* [formatting](#snakesee.formatting)
* [Classes](#snakesee.formatting-classes)

  + [StatusColor](#snakesee.formatting.StatusColor)
  + [StatusStyle](#snakesee.formatting.StatusStyle)

    - [Attributes](#snakesee.formatting.StatusStyle-attributes)

      * [rich\_style](#snakesee.formatting.StatusStyle.rich_style)
* [Functions](#snakesee.formatting-functions)

  + [format\_count](#snakesee.formatting.format_count)
  + [format\_count\_compact](#snakesee.formatting.format_count_compact)
  + [format\_duration](#snakesee.formatting.format_duration)
  + [format\_duration\_range](#snakesee.formatting.format_duration_range)
  + [format\_eta](#snakesee.formatting.format_eta)
  + [format\_percentage](#snakesee.formatting.format_percentage)
  + [format\_size](#snakesee.formatting.format_size)
  + [format\_size\_rate](#snakesee.formatting.format_size_rate)
  + [format\_wildcards](#snakesee.formatting.format_wildcards)
  + [get\_status\_color](#snakesee.formatting.get_status_color)
  + [get\_status\_style](#snakesee.formatting.get_status_style)

# formatting

Centralized formatting utilities for snakesee.

This module provides consistent formatting functions for durations, sizes,
percentages, and status display throughout the application.

## Classes[¶](#snakesee.formatting-classes "Permanent link")

### StatusColor [¶](#snakesee.formatting.StatusColor "Permanent link")

Bases: `str`, `Enum`

Standard colors for workflow/job status display.

Source code in `snakesee/formatting.py`

|  |  |
| --- | --- |
| ``` 16 17 18 19 20 21 22 23 24 25 ``` | ``` class StatusColor(str, Enum):     """Standard colors for workflow/job status display."""      RUNNING = "green"     COMPLETED = "blue"     FAILED = "red"     INCOMPLETE = "yellow"     UNKNOWN = "yellow"     PENDING = "dim"     ERROR = "red" ``` |

### StatusStyle `dataclass` [¶](#snakesee.formatting.StatusStyle "Permanent link")

Complete styling for a status indicator.

Source code in `snakesee/formatting.py`

|  |  |
| --- | --- |
| ``` 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 ``` | ``` @dataclass(frozen=True) class StatusStyle:     """Complete styling for a status indicator."""      color: str     icon: str = ""     bold: bool = False      @property     def rich_style(self) -> str:         """Return Rich markup style string."""         style = self.color         if self.bold:             style = f"bold {style}"         return style ``` |

#### Attributes[¶](#snakesee.formatting.StatusStyle-attributes "Permanent link")

##### rich\_style `property` [¶](#snakesee.formatting.StatusStyle.rich_style "Permanent link")

```
rich_style: str
```

Return Rich markup style string.

## Functions[¶](#snakesee.formatting-functions "Permanent link")

### format\_count [¶](#snakesee.formatting.format_count "Permanent link")

```
format_count(current: int, total: int, include_percentage: bool = True) -> str
```

Format a count as "X of Y (Z%)".

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `current` | `int` | Current count. | *required* |
| `total` | `int` | Total count. | *required* |
| `include_percentage` | `bool` | Whether to include percentage. | `True` |

Returns:

| Type | Description |
| --- | --- |
| `str` | Formatted count string. |

Examples:

```
>>> format_count(5, 10)
'5 of 10 (50.0%)'
>>> format_count(5, 10, include_percentage=False)
'5 of 10'
```

Source code in `snakesee/formatting.py`

|  |  |
| --- | --- |
| ``` 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 ``` | ``` def format_count(     current: int,     total: int,     include_percentage: bool = True, ) -> str:     """Format a count as "X of Y (Z%)".      Args:         current: Current count.         total: Total count.         include_percentage: Whether to include percentage.      Returns:         Formatted count string.      Examples:         >>> format_count(5, 10)         '5 of 10 (50.0%)'         >>> format_count(5, 10, include_percentage=False)         '5 of 10'     """     if include_percentage and total > 0:         pct = (current / total) * 100         return f"{current} of {total} ({pct:.1f}%)"     return f"{current} of {total}" ``` |

### format\_count\_compact [¶](#snakesee.formatting.format_count_compact "Permanent link")

```
format_count_compact(current: int, total: int) -> str
```

Format a count as "X/Y".

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `current` | `int` | Current count. | *required* |
| `total` | `int` | Total count. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `str` | Compact count string. |

Examples:

```
>>> format_count_compact(5, 10)
'5/10'
```

Source code in `snakesee/formatting.py`

|  |  |
| --- | --- |
| ``` 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 ``` | ``` def format_count_compact(current: int, total: int) -> str:     """Format a count as "X/Y".      Args:         current: Current count.         total: Total count.      Returns:         Compact count string.      Examples:         >>> format_count_compact(5, 10)         '5/10'     """     return f"{current}/{total}" ``` |

### format\_duration [¶](#snakesee.formatting.format_duration "Permanent link")

```
format_duration(seconds: float, precision: Literal['auto', 'seconds', 'minutes', 'hours'] = 'auto') -> str
```

Format seconds as human-readable duration.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `seconds` | `float` | Duration in seconds. | *required* |
| `precision` | `Literal['auto', 'seconds', 'minutes', 'hours']` | Level of precision for output. - "auto": Choose based on magnitude - "seconds": Always include seconds - "minutes": Include minutes, drop seconds for large values - "hours": Only show hours for very large values | `'auto'` |

Returns:

| Type | Description |
| --- | --- |
| `str` | Formatted duration string (e.g., "5s", "2m 30s", "1h 15m"). |

Examples:

```
>>> format_duration(45)
'45s'
>>> format_duration(125)
'2m 5s'
>>> format_duration(3725)
'1h 2m'
>>> format_duration(float("inf"))
'unknown'
```

Source code in `snakesee/formatting.py`

|  |  |
| --- | --- |
| ``` 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 ``` | ``` def format_duration(     seconds: float,     precision: Literal["auto", "seconds", "minutes", "hours"] = "auto", ) -> str:     """Format seconds as human-readable duration.      Args:         seconds: Duration in seconds.         precision: Level of precision for output.             - "auto": Choose based on magnitude             - "seconds": Always include seconds             - "minutes": Include minutes, drop seconds for large values             - "hours": Only show hours for very large values      Returns:         Formatted duration string (e.g., "5s", "2m 30s", "1h 15m").      Examples:         >>> format_duration(45)         '45s'         >>> format_duration(125)         '2m 5s'         >>> format_duration(3725)         '1h 2m'         >>> format_duration(float("inf"))         'unknown'     """     if seconds == float("inf"):         return "unknown"     if seconds < 0:         return "0s"      if precision == "auto":         if seconds < SECONDS_PER_MINUTE:             return f"{int(seconds)}s"         if seconds < SECONDS_PER_HOUR:             minutes = int(seconds // SECONDS_PER_MINUTE)             secs = int(seconds % SECONDS_PER_MINUTE)             return f"{minutes}m {secs}s" if secs > 0 else f"{minutes}m"         hours = int(seconds // SECONDS_PER_HOUR)         minutes = int((seconds % SECONDS_PER_HOUR) // SECONDS_PER_MINUTE)         return f"{hours}h {minutes}m" if minutes > 0 else f"{hours}h"      if precision == "seconds":         if seconds < SECONDS_PER_MINUTE:             return f"{int(seconds)}s"         if seconds < SECONDS_PER_HOUR:             minutes = int(seconds // SECONDS_PER_MINUTE)             secs = int(seconds % SECONDS_PER_MINUTE)             return f"{minutes}m {secs}s"         hours = int(seconds // SECONDS_PER_HOUR)         minutes = int((seconds % SECONDS_PER_HOUR) // SECONDS_PER_MINUTE)         secs = int(seconds % SECONDS_PER_MINUTE)         if secs > 0:             return f"{hours}h {minutes}m {secs}s"         return f"{hours}h {minutes}m" if minutes > 0 else f"{hours}h"      if precision == "minutes":         if seconds < SECONDS_PER_MINUTE:             return f"{int(seconds)}s"         minutes = int(seconds // SECONDS_PER_MINUTE)         if seconds < SECONDS_PER_HOUR:             return f"{minutes}m"         hours = int(seconds // SECONDS_PER_HOUR)         minutes = int((seconds % SECONDS_PER_HOUR) // SECONDS_PER_MINUTE)         return f"{hours}h {minutes}m" if minutes > 0 else f"{hours}h"      # precision == "hours"     if seconds < SECONDS_PER_HOUR:         return f"{int(seconds / SECONDS_PER_MINUTE)}m"     hours_float = seconds / SECONDS_PER_HOUR     return f"{hours_float:.1f}h" ``` |

### format\_duration\_range [¶](#snakesee.formatting.format_duration_range "Permanent link")

```
format_duration_range(lower: float, upper: float, separator: str = ' - ') -> str
```

Format a duration range.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `lower` | `float` | Lower bound in seconds. | *required* |
| `upper` | `float` | Upper bound in seconds. | *required* |
| `separator` | `str` | String between lower and upper. | `' - '` |

Returns:

| Type | Description |
| --- | --- |
| `str` | Formatted range string (e.g., "2m - 5m"). |

Examples:

```
>>> format_duration_range(60, 180)
'1m - 3m'
>>> format_duration_range(30, 90)
'30s - 1m 30s'
>>> format_duration_range(3600, 7200)
'1h - 2h'
```

Source code in `snakesee/formatting.py`

|  |  |
| --- | --- |
| ``` 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 ``` | ``` def format_duration_range(     lower: float,     upper: float,     separator: str = " - ", ) -> str:     """Format a duration range.      Args:         lower: Lower bound in seconds.         upper: Upper bound in seconds.         separator: String between lower and upper.      Returns:         Formatted range string (e.g., "2m - 5m").      Examples:         >>> format_duration_range(60, 180)         '1m - 3m'         >>> format_duration_range(30, 90)         '30s - 1m 30s'         >>> format_duration_range(3600, 7200)         '1h - 2h'     """     return f"{format_duration(max(0, lower))}{separator}{format_duration(upper)}" ``` |

### format\_eta [¶](#snakesee.formatting.format_eta "Permanent link")

```
format_eta(seconds_remaining: float, lower_bound: float | None = None, upper_bound: float | None = None, confidence: float = 1.0) -> str
```

Format an ETA with optional range and confidence indication.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `seconds_remaining` | `float` | Expected seconds remaining. | *required* |
| `lower_bound` | `f