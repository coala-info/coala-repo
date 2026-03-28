[ ]
[ ]

[Skip to content](#snakesee.estimation.pending_inferrer)

snakesee

pending\_inferrer

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
    - [x]

      [estimation](index.html)

      estimation
      * [data\_loader](data_loader.html)
      * [estimator](estimator.html)
      * [ ]

        pending\_inferrer

        [pending\_inferrer](pending_inferrer.html)

        Table of contents
        + [pending\_inferrer](#snakesee.estimation.pending_inferrer)
        + [Classes](#snakesee.estimation.pending_inferrer-classes)

          - [PendingRuleInferrer](#snakesee.estimation.pending_inferrer.PendingRuleInferrer)

            * [Functions](#snakesee.estimation.pending_inferrer.PendingRuleInferrer-functions)

              + [infer](#snakesee.estimation.pending_inferrer.PendingRuleInferrer.infer)
      * [rule\_matcher](rule_matcher.html)
    - [estimator](../estimator.html)
    - [events](../events.html)
    - [exceptions](../exceptions.html)
    - [formatting](../formatting.html)
    - [log\_handler\_script](../log_handler_script.html)
    - [logging](../logging.html)
    - [models](../models.html)
    - [parameter\_validation](../parameter_validation.html)
    - [ ]

      [parser](../parser/index.html)

      parser
      * [core](../parser/core.html)
      * [failure\_tracker](../parser/failure_tracker.html)
      * [file\_position](../parser/file_position.html)
      * [job\_tracker](../parser/job_tracker.html)
      * [line\_parser](../parser/line_parser.html)
      * [log\_reader](../parser/log_reader.html)
      * [metadata](../parser/metadata.html)
      * [patterns](../parser/patterns.html)
      * [stats](../parser/stats.html)
      * [utils](../parser/utils.html)
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

* [pending\_inferrer](#snakesee.estimation.pending_inferrer)
* [Classes](#snakesee.estimation.pending_inferrer-classes)

  + [PendingRuleInferrer](#snakesee.estimation.pending_inferrer.PendingRuleInferrer)

    - [Functions](#snakesee.estimation.pending_inferrer.PendingRuleInferrer-functions)

      * [infer](#snakesee.estimation.pending_inferrer.PendingRuleInferrer.infer)

# pending\_inferrer

Inference of pending rule distribution for time estimation.

## Classes[¶](#snakesee.estimation.pending_inferrer-classes "Permanent link")

### PendingRuleInferrer [¶](#snakesee.estimation.pending_inferrer.PendingRuleInferrer "Permanent link")

Infers the distribution of pending jobs by rule.

When we know the total pending count but not the breakdown by rule,
this class infers the distribution based on:
1. Expected job counts (from Snakemake's Job stats table) if available
2. Proportional inference from completed job distribution otherwise

Source code in `snakesee/estimation/pending_inferrer.py`

|  |  |
| --- | --- |
| ``` 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 ``` | ``` class PendingRuleInferrer:     """Infers the distribution of pending jobs by rule.      When we know the total pending count but not the breakdown by rule,     this class infers the distribution based on:     1. Expected job counts (from Snakemake's Job stats table) if available     2. Proportional inference from completed job distribution otherwise     """      def infer(         self,         completed_by_rule: dict[str, int],         pending_count: int,         expected_job_counts: dict[str, int] | None = None,         current_rules: set[str] | None = None,         running_by_rule: dict[str, int] | None = None,     ) -> dict[str, int]:         """Infer the distribution of pending jobs by rule.          Args:             completed_by_rule: Count of completed jobs per rule.             pending_count: Total number of pending jobs.             expected_job_counts: Expected counts from Job stats table (most accurate).             current_rules: Set of rules in current workflow (filters deleted rules).             running_by_rule: Count of running jobs per rule.          Returns:             Estimated count of pending jobs per rule.         """         if pending_count <= 0:             return {}          running_by_rule = running_by_rule or {}          # Use exact calculation if we have expected job counts         if expected_job_counts:             return self._exact_calculation(                 expected_job_counts,                 completed_by_rule,                 running_by_rule,             )          # Fall back to proportional inference         return self._proportional_inference(             completed_by_rule,             pending_count,             current_rules,         )      def _exact_calculation(         self,         expected_job_counts: dict[str, int],         completed_by_rule: dict[str, int],         running_by_rule: dict[str, int],     ) -> dict[str, int]:         """Calculate pending using expected - completed - running."""         pending_rules: dict[str, int] = {}          for rule, expected in expected_job_counts.items():             completed = completed_by_rule.get(rule, 0)             running = running_by_rule.get(rule, 0)             remaining = expected - completed - running             if remaining > 0:                 pending_rules[rule] = remaining          return pending_rules      def _proportional_inference(         self,         completed_by_rule: dict[str, int],         pending_count: int,         current_rules: set[str] | None,     ) -> dict[str, int]:         """Infer pending distribution proportionally to completed jobs.          Note: Due to rounding, the sum of returned values may not exactly         equal pending_count. This is expected and the estimation handles         this gracefully.         """         if not completed_by_rule:             return {}          # Filter out deleted rules if current_rules is provided         if current_rules is not None:             completed_by_rule = {r: c for r, c in completed_by_rule.items() if r in current_rules}          total_completed = sum(completed_by_rule.values())         if total_completed == 0:             return {}          pending_rules: dict[str, int] = {}         for rule, count in completed_by_rule.items():             proportion = count / total_completed             estimated = round(pending_count * proportion)             if estimated > 0:                 pending_rules[rule] = estimated          return pending_rules ``` |

#### Functions[¶](#snakesee.estimation.pending_inferrer.PendingRuleInferrer-functions "Permanent link")

##### infer [¶](#snakesee.estimation.pending_inferrer.PendingRuleInferrer.infer "Permanent link")

```
infer(completed_by_rule: dict[str, int], pending_count: int, expected_job_counts: dict[str, int] | None = None, current_rules: set[str] | None = None, running_by_rule: dict[str, int] | None = None) -> dict[str, int]
```

Infer the distribution of pending jobs by rule.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `completed_by_rule` | `dict[str, int]` | Count of completed jobs per rule. | *required* |
| `pending_count` | `int` | Total number of pending jobs. | *required* |
| `expected_job_counts` | `dict[str, int] | None` | Expected counts from Job stats table (most accurate). | `None` |
| `current_rules` | `set[str] | None` | Set of rules in current workflow (filters deleted rules). | `None` |
| `running_by_rule` | `dict[str, int] | None` | Count of running jobs per rule. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `dict[str, int]` | Estimated count of pending jobs per rule. |

Source code in `snakesee/estimation/pending_inferrer.py`

|  |  |
| --- | --- |
| ``` 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 ``` | ``` def infer(     self,     completed_by_rule: dict[str, int],     pending_count: int,     expected_job_counts: dict[str, int] | None = None,     current_rules: set[str] | None = None,     running_by_rule: dict[str, int] | None = None, ) -> dict[str, int]:     """Infer the distribution of pending jobs by rule.      Args:         completed_by_rule: Count of completed jobs per rule.         pending_count: Total number of pending jobs.         expected_job_counts: Expected counts from Job stats table (most accurate).         current_rules: Set of rules in current workflow (filters deleted rules).         running_by_rule: Count of running jobs per rule.      Returns:         Estimated count of pending jobs per rule.     """     if pending_count <= 0:         return {}      running_by_rule = running_by_rule or {}      # Use exact calculation if we have expected job counts     if expected_job_counts:         return self._exact_calculation(             expected_job_counts,             completed_by_rule,             running_by_rule,         )      # Fall back to proportional inference     return self._proportional_inference(         completed_by_rule,         pending_count,         current_rules,     ) ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)