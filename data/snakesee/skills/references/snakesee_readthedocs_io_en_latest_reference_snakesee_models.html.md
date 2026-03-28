[ ]
[ ]

[Skip to content](#snakesee.models)

snakesee

models

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
    - [ ]

      models

      [models](models.html)

      Table of contents
      * [models](#snakesee.models)
      * [Classes](#snakesee.models-classes)

        + [JobInfo](#snakesee.models.JobInfo)

          - [Attributes](#snakesee.models.JobInfo-attributes)

            * [duration](#snakesee.models.JobInfo.duration)
            * [elapsed](#snakesee.models.JobInfo.elapsed)
        + [RuleTimingStats](#snakesee.models.RuleTimingStats)

          - [Attributes](#snakesee.models.RuleTimingStats-attributes)

            * [coefficient\_of\_variation](#snakesee.models.RuleTimingStats.coefficient_of_variation)
            * [count](#snakesee.models.RuleTimingStats.count)
            * [is\_high\_variance](#snakesee.models.RuleTimingStats.is_high_variance)
            * [max\_duration](#snakesee.models.RuleTimingStats.max_duration)
            * [mean\_duration](#snakesee.models.RuleTimingStats.mean_duration)
            * [median\_input\_size](#snakesee.models.RuleTimingStats.median_input_size)
            * [min\_duration](#snakesee.models.RuleTimingStats.min_duration)
            * [std\_dev](#snakesee.models.RuleTimingStats.std_dev)
          - [Functions](#snakesee.models.RuleTimingStats-functions)

            * [recency\_factor](#snakesee.models.RuleTimingStats.recency_factor)
            * [recent\_consistency](#snakesee.models.RuleTimingStats.recent_consistency)
            * [size\_scaled\_estimate](#snakesee.models.RuleTimingStats.size_scaled_estimate)
            * [weighted\_mean](#snakesee.models.RuleTimingStats.weighted_mean)
        + [ThreadTimingStats](#snakesee.models.ThreadTimingStats)

          - [Functions](#snakesee.models.ThreadTimingStats-functions)

            * [get\_best\_match](#snakesee.models.ThreadTimingStats.get_best_match)
            * [get\_stats\_for\_threads](#snakesee.models.ThreadTimingStats.get_stats_for_threads)
        + [TimeEstimate](#snakesee.models.TimeEstimate)

          - [Functions](#snakesee.models.TimeEstimate-functions)

            * [format\_eta](#snakesee.models.TimeEstimate.format_eta)
        + [WildcardTimingStats](#snakesee.models.WildcardTimingStats)

          - [Functions](#snakesee.models.WildcardTimingStats-functions)

            * [get\_most\_predictive\_key](#snakesee.models.WildcardTimingStats.get_most_predictive_key)
            * [get\_stats\_for\_value](#snakesee.models.WildcardTimingStats.get_stats_for_value)
        + [WorkflowProgress](#snakesee.models.WorkflowProgress)

          - [Attributes](#snakesee.models.WorkflowProgress-attributes)

            * [elapsed\_seconds](#snakesee.models.WorkflowProgress.elapsed_seconds)
            * [pending\_jobs](#snakesee.models.WorkflowProgress.pending_jobs)
            * [percent\_complete](#snakesee.models.WorkflowProgress.percent_complete)
        + [WorkflowStatus](#snakesee.models.WorkflowStatus)
      * [Functions](#snakesee.models-functions)

        + [format\_duration](#snakesee.models.format_duration)
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

* [models](#snakesee.models)
* [Classes](#snakesee.models-classes)

  + [JobInfo](#snakesee.models.JobInfo)

    - [Attributes](#snakesee.models.JobInfo-attributes)

      * [duration](#snakesee.models.JobInfo.duration)
      * [elapsed](#snakesee.models.JobInfo.elapsed)
  + [RuleTimingStats](#snakesee.models.RuleTimingStats)

    - [Attributes](#snakesee.models.RuleTimingStats-attributes)

      * [coefficient\_of\_variation](#snakesee.models.RuleTimingStats.coefficient_of_variation)
      * [count](#snakesee.models.RuleTimingStats.count)
      * [is\_high\_variance](#snakesee.models.RuleTimingStats.is_high_variance)
      * [max\_duration](#snakesee.models.RuleTimingStats.max_duration)
      * [mean\_duration](#snakesee.models.RuleTimingStats.mean_duration)
      * [median\_input\_size](#snakesee.models.RuleTimingStats.median_input_size)
      * [min\_duration](#snakesee.models.RuleTimingStats.min_duration)
      * [std\_dev](#snakesee.models.RuleTimingStats.std_dev)
    - [Functions](#snakesee.models.RuleTimingStats-functions)

      * [recency\_factor](#snakesee.models.RuleTimingStats.recency_factor)
      * [recent\_consistency](#snakesee.models.RuleTimingStats.recent_consistency)
      * [size\_scaled\_estimate](#snakesee.models.RuleTimingStats.size_scaled_estimate)
      * [weighted\_mean](#snakesee.models.RuleTimingStats.weighted_mean)
  + [ThreadTimingStats](#snakesee.models.ThreadTimingStats)

    - [Functions](#snakesee.models.ThreadTimingStats-functions)

      * [get\_best\_match](#snakesee.models.ThreadTimingStats.get_best_match)
      * [get\_stats\_for\_threads](#snakesee.models.ThreadTimingStats.get_stats_for_threads)
  + [TimeEstimate](#snakesee.models.TimeEstimate)

    - [Functions](#snakesee.models.TimeEstimate-functions)

      * [format\_eta](#snakesee.models.TimeEstimate.format_eta)
  + [WildcardTimingStats](#snakesee.models.WildcardTimingStats)

    - [Functions](#snakesee.models.WildcardTimingStats-functions)

      * [get\_most\_predictive\_key](#snakesee.models.WildcardTimingStats.get_most_predictive_key)
      * [get\_stats\_for\_value](#snakesee.models.WildcardTimingStats.get_stats_for_value)
  + [WorkflowProgress](#snakesee.models.WorkflowProgress)

    - [Attributes](#snakesee.models.WorkflowProgress-attributes)

      * [elapsed\_seconds](#snakesee.models.WorkflowProgress.elapsed_seconds)
      * [pending\_jobs](#snakesee.models.WorkflowProgress.pending_jobs)
      * [percent\_complete](#snakesee.models.WorkflowProgress.percent_complete)
  + [WorkflowStatus](#snakesee.models.WorkflowStatus)
* [Functions](#snakesee.models-functions)

  + [format\_duration](#snakesee.models.format_duration)

# models

Data models for workflow monitoring.

## Classes[¶](#snakesee.models-classes "Permanent link")

### JobInfo `dataclass` [¶](#snakesee.models.JobInfo "Permanent link")

Information about a single job execution.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `rule` | `str` | The name of the rule that was executed. |
| `job_id` | `str | None` | Optional job identifier. |
| `start_time` | `float | None` | Unix timestamp when the job started. |
| `end_time` | `float | None` | Unix timestamp when the job completed (None if still running). |
| `output_file` | `Path | None` | The output file path this job produces. |
| `wildcards` | `dict[str, str] | None` | Dictionary of wildcard names to values (e.g., {"sample": "A", "batch": "1"}). |
| `input_size` | `int | None` | Total size of input files in bytes (None if unknown). |
| `threads` | `int | None` | Number of threads allocated to this job (None if unknown). |
| `log_file` | `Path | None` | Path to the job's log file (parsed from snakemake log directive). |

Source code in `snakesee/models.py`

|  |  |
| --- | --- |
| ``` 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 ``` | ``` @dataclass(frozen=True, slots=True) class JobInfo:     """     Information about a single job execution.      Attributes:         rule: The name of the rule that was executed.         job_id: Optional job identifier.         start_time: Unix timestamp when the job started.         end_time: Unix timestamp when the job completed (None if still running).         output_file: The output file path this job produces.         wildcards: Dictionary of wildcard names to values (e.g., {"sample": "A", "batch": "1"}).         input_size: Total size of input files in bytes (None if unknown).         threads: Number of threads allocated to this job (None if unknown).         log_file: Path to the job's log file (parsed from snakemake log directive).     """      rule: str     job_id: str | None = None     start_time: float | None = None     end_time: float | None = None     output_file: Path | None = None     wildcards: dict[str, str] | None = None     input_size: int | None = None     threads: int | None = None     log_file: Path | None = None      @property     def elapsed(self) -> float | None:         """         Elapsed time in seconds.          Returns:             Seconds elapsed since start, or None if start_time not set.         """         if self.start_time is None:             return None         end = self.end_time or get_clock().now()         result = ClockUtils.calculate_duration(self.start_time, end, f"job {self.rule}")         if not result.is_valid:             logger.warning(                 "Negative elapsed time detected for job %s: %.2fs (clock skew?)",                 self.rule,                 result.raw_value,             )         return result.value      @property     def duration(self) -> float | None:         """         Total duration in seconds (only for completed jobs).          Returns:             Duration in seconds (always >= 0), or None if job not completed.         """         if self.start_time is not None and self.end_time is not None:             result = ClockUtils.calculate_duration(                 self.start_time, self.end_time, f"job {self.rule}"             )             if not result.is_valid:                 logger.warning(                     "Negative duration detected for job %s: %.2fs (clock skew?)",                     self.rule,                     result.raw_value,                 )             return result.value         return None ``` |

#### Attributes[¶](#snakesee.models.JobInfo-attributes "Permanent link")

##### duration `property` [¶](#snakesee.models.JobInfo.duration "Permanent link")

```
duration: float | None
```

Total duration in seconds (only for completed jobs).

Returns:

| Type | Description |
| --- | --- |
| `float | None` | Duration in seconds (always >= 0), or None if job not completed. |

##### elapsed `property` [¶](#snakesee.models.JobInfo.elapsed "Permanent link")

```
elapsed: float | None
```

Elapsed time in seconds.

Returns:

| Type | Description |
| --- | --- |
| `float | None` | Seconds elapsed since start, or None if start\_time not set. |

### RuleTimingStats `dataclass` [¶](#snakesee.models.RuleTimingStats "Permanent link")

Aggregated timing statistics for a rule.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `rule` | `str` | The name of the rule. |
| `durations` | `list[float]` | List of observed durations in seconds. |
| `timestamps` | `list[float]` | List of Unix timestamps when each run completed (parallel to durations). |
| `input_sizes` | `list[int | None]` | List of input file sizes in bytes (parallel to durations, None for unknown). |

Source code in `snakesee/models.py`

|  |  |
| --- | --- |
| ``` 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 ``` | ``` @dataclass class RuleTimingStats:     """     Aggregated timing statistics for a rule.      Attributes:         rule: The name of the rule.         durations: List of observed durations in seconds.         timestamps: List of Unix timestamps when each run completed (parallel to durations).         input_sizes: List of input file sizes in bytes (parall