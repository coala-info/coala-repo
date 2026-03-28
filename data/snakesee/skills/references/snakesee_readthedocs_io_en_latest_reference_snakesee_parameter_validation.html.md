[ ]
[ ]

[Skip to content](#snakesee.parameter_validation)

snakesee

parameter\_validation

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
    - [ ]

      parameter\_validation

      [parameter\_validation](parameter_validation.html)

      Table of contents
      * [parameter\_validation](#snakesee.parameter_validation)
      * [Classes](#snakesee.parameter_validation-classes)
      * [Functions](#snakesee.parameter_validation-functions)

        + [require\_in\_range](#snakesee.parameter_validation.require_in_range)
        + [require\_non\_negative](#snakesee.parameter_validation.require_non_negative)
        + [require\_not\_empty](#snakesee.parameter_validation.require_not_empty)
        + [require\_positive](#snakesee.parameter_validation.require_positive)
        + [validate\_in\_range](#snakesee.parameter_validation.validate_in_range)
        + [validate\_non\_negative](#snakesee.parameter_validation.validate_non_negative)
        + [validate\_not\_empty](#snakesee.parameter_validation.validate_not_empty)
        + [validate\_positive](#snakesee.parameter_validation.validate_positive)
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

* [parameter\_validation](#snakesee.parameter_validation)
* [Classes](#snakesee.parameter_validation-classes)
* [Functions](#snakesee.parameter_validation-functions)

  + [require\_in\_range](#snakesee.parameter_validation.require_in_range)
  + [require\_non\_negative](#snakesee.parameter_validation.require_non_negative)
  + [require\_not\_empty](#snakesee.parameter_validation.require_not_empty)
  + [require\_positive](#snakesee.parameter_validation.require_positive)
  + [validate\_in\_range](#snakesee.parameter_validation.validate_in_range)
  + [validate\_non\_negative](#snakesee.parameter_validation.validate_non_negative)
  + [validate\_not\_empty](#snakesee.parameter_validation.validate_not_empty)
  + [validate\_positive](#snakesee.parameter_validation.validate_positive)

# parameter\_validation

Parameter validation decorators and utilities.

This module provides validation decorators and functions for checking
function arguments and parameters.

Example

@validate\_positive("half\_life\_days", "half\_life\_logs")
def weighted\_mean(self, half\_life\_days=7.0, half\_life\_logs=10):
...

## Classes[¶](#snakesee.parameter_validation-classes "Permanent link")

## Functions[¶](#snakesee.parameter_validation-functions "Permanent link")

### require\_in\_range [¶](#snakesee.parameter_validation.require_in_range "Permanent link")

```
require_in_range(value: float | int, name: str, min_value: float | None = None, max_value: float | None = None) -> float | int
```

Validate that a value is within a range.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `value` | `float | int` | The value to check (must not be None). | *required* |
| `name` | `str` | Parameter name for error messages. | *required* |
| `min_value` | `float | None` | Minimum allowed value (inclusive). | `None` |
| `max_value` | `float | None` | Maximum allowed value (inclusive). | `None` |

Returns:

| Type | Description |
| --- | --- |
| `float | int` | The value if valid. |

Raises:

| Type | Description |
| --- | --- |
| `[InvalidParameterError](index.html#snakesee.exceptions.InvalidParameterError "InvalidParameterError (snakesee.exceptions.InvalidParameterError)")` | If value is None or outside the range. |

Source code in `snakesee/parameter_validation.py`

|  |  |
| --- | --- |
| ``` 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 ``` | ``` def require_in_range(     value: float | int,     name: str,     min_value: float | None = None,     max_value: float | None = None, ) -> float | int:     """Validate that a value is within a range.      Args:         value: The value to check (must not be None).         name: Parameter name for error messages.         min_value: Minimum allowed value (inclusive).         max_value: Maximum allowed value (inclusive).      Returns:         The value if valid.      Raises:         InvalidParameterError: If value is None or outside the range.     """     if value is None:         raise InvalidParameterError(parameter=name, value=value, constraint="not None")     if min_value is not None and value < min_value:         raise InvalidParameterError(parameter=name, value=value, constraint=f">= {min_value}")     if max_value is not None and value > max_value:         raise InvalidParameterError(parameter=name, value=value, constraint=f"<= {max_value}")     return value ``` |

### require\_non\_negative [¶](#snakesee.parameter_validation.require_non_negative "Permanent link")

```
require_non_negative(value: float | int, name: str) -> float | int
```

Validate that a value is non-negative.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `value` | `float | int` | The value to check (must not be None). | *required* |
| `name` | `str` | Parameter name for error messages. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `float | int` | The value if valid. |

Raises:

| Type | Description |
| --- | --- |
| `[InvalidParameterError](index.html#snakesee.exceptions.InvalidParameterError "InvalidParameterError (snakesee.exceptions.InvalidParameterError)")` | If value is None or negative. |

Source code in `snakesee/parameter_validation.py`

|  |  |
| --- | --- |
| ``` 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 ``` | ``` def require_non_negative(value: float | int, name: str) -> float | int:     """Validate that a value is non-negative.      Args:         value: The value to check (must not be None).         name: Parameter name for error messages.      Returns:         The value if valid.      Raises:         InvalidParameterError: If value is None or negative.     """     if value is None:         raise InvalidParameterError(parameter=name, value=value, constraint="not None")     if value < 0:         raise InvalidParameterError(parameter=name, value=value, constraint="non-negative (>= 0)")     return value ``` |

### require\_not\_empty [¶](#snakesee.parameter_validation.require_not_empty "Permanent link")

```
require_not_empty(value: Sequence[Any], name: str) -> Sequence[Any]
```

Validate that a sequence is not empty.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `value` | `Sequence[Any]` | The sequence to check (must not be None). | *required* |
| `name` | `str` | Parameter name for error messages. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `Sequence[Any]` | The value if valid. |

Raises:

| Type | Description |
| --- | --- |
| `[InvalidParameterError](index.html#snakesee.exceptions.InvalidParameterError "InvalidParameterError (snakesee.exceptions.InvalidParameterError)")` | If value is None or sequence is empty. |

Source code in `snakesee/parameter_validation.py`

|  |  |
| --- | --- |
| ``` 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 ``` | ``` def require_not_empty(value: Sequence[Any], name: str) -> Sequence[Any]:     """Validate that a sequence is not empty.      Args:         value: The sequence to check (must not be None).         name: Parameter name for error messages.      Returns:         The value if valid.      Raises:         InvalidParameterError: If value is None or sequence is empty.     """     if value is None:         raise InvalidParameterError(parameter=name, value=value, constraint="not None")     if len(value) == 0:         raise InvalidParameterError(parameter=name, value=value, constraint="non-empty")     return value ``` |

### require\_positive [¶](#snakesee.parameter_validation.require_positive "Permanent link")

```
require_positive(value: float | int, name: str) -> float | int
```

Validate that a value is positive.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `value` | `float | int` | The value to check (must not be None). | *required* |
| `name` | `str` | Parameter name for error messages. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `float | int` | The value if valid. |

Raises:

| Type | Description |
| --- | --- |
| `[InvalidParameterError](index.html#snakesee.exceptions.InvalidParameterError "InvalidParameterError (snakesee.exceptions.InvalidParameterError)")` | If value is None or not positive. |

Source code in `snakesee/parameter_validation.py`

|  |  |
| --- | --- |
| ``` 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 ``` | ``` def require_positive(value: float | int, name: str) -> float | int:     """Validate that a value is positive.      Args:         value: The value to check (must not be None).         name: Parameter name for error messages.      Returns:         The value if valid.      Raises:         InvalidParameterError: If value is None or not positive.     """     if value is None:         raise InvalidParameterError(parameter=name, value=value, constraint="not None")     if value <= 0:         raise InvalidParameterError(parameter=name, value=value, constraint="positive (> 0)")     return value ``` |

### validate\_in\_range [¶](#snakesee.parameter_validation.validate_in_range "Permanent link")

```
validate_in_range(param_name: str, min_value: float | None = None, max_value: float | None = None) -> Callable[[Callable[P, R]], Callable[P, R]]
```

Decorator to validate that a parameter is within a specified range.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `param_name` | `str` | Name of the parameter to validate. | *required* |
| `min_value` | `float | None` | Minimum allowed value (inclusive). None means no minimum. | `None` |
| `max_value` | `float | None` | Maximum allowed value (inclusive). None means no maximum. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `Callable[[Callable[P, R]], Callable[P, R]]` | Decorator that validates the specified parameter. |

Raises:

| Type | Description |
| --- | --- |
| `[InvalidParameterError](index.html#snakesee.exceptions.InvalidParameterError "InvalidParameterError (snakesee.exceptions.InvalidParameterError)")` | If the parameter is outside the range. |

Note

None values are allowed and bypass validation, making this suitable
for optional parameters with None defaults.

Example

@validate\_in\_range("confidence", min\_value=0.0, max\_value=1.0)
def set\_confidence(self, confidence):
...

Source code in `snakesee/parameter_validation.py`

|  |  |
| --- | --- |
| ``` 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 ``` | ``` def validate_in_range(     param_name: str,     min_value: float | None = None,     max_value: float | None = None, ) -> Callable[[Callable[P, R]], Callable[P, R]]:     """Decorator to validate that a parameter is within a specified range.      Args:         param_name: Name of the parameter to validate.         min_value: Minimum allowed value (inclusive). None means no minimum.         max_value: Maximum allowed value (inclusive). None means no maximum.      Returns:         Decorator that validates the specified parameter.      Raises:         InvalidParameterError: If the parameter is outside the range.      Note:         None values are allowed and bypass validation, making this suitable         for optional parameters with None defaults.      Example:         @validate_in_range("confidence", min_value=0.0, max_value=1.0)         def set_confidence(self, confidence):             ...     """      def decorator(func: Callable[P, R]) -> Callable[P, R]:         # Cache signature at decoration time for better performance         sig = inspect.signature(func)          @functools.wraps(func)         def wrapper(*args: P.args, **kwargs: P.kwargs) -> R:             bound = sig.bind_partial(*args, **kwargs)             bound.apply_defaults()              if param_name in bound.arguments:                 value = bound.arguments[param_name]                 if value is not None:                     if min_value is not None and value < min_value:                         raise InvalidParameterError(                             parameter=param_name,                             value=value,                             constraint=f">= {min_value}",                         )                     if max_value is not None and value > max_value:                         raise I