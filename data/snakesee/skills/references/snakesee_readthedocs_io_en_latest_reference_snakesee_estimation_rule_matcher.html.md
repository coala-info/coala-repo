[ ]
[ ]

[Skip to content](#snakesee.estimation.rule_matcher)

snakesee

rule\_matcher

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
      * [pending\_inferrer](pending_inferrer.html)
      * [ ]

        rule\_matcher

        [rule\_matcher](rule_matcher.html)

        Table of contents
        + [rule\_matcher](#snakesee.estimation.rule_matcher)
        + [Classes](#snakesee.estimation.rule_matcher-classes)

          - [RuleMatchingEngine](#snakesee.estimation.rule_matcher.RuleMatchingEngine)

            * [Functions](#snakesee.estimation.rule_matcher.RuleMatchingEngine-functions)

              + [\_\_init\_\_](#snakesee.estimation.rule_matcher.RuleMatchingEngine.__init__)
              + [find\_best\_match](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_best_match)
              + [find\_by\_code\_hash](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_by_code_hash)
              + [find\_similar](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_similar)
        + [Functions](#snakesee.estimation.rule_matcher-functions)

          - [levenshtein\_distance](#snakesee.estimation.rule_matcher.levenshtein_distance)
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

* [rule\_matcher](#snakesee.estimation.rule_matcher)
* [Classes](#snakesee.estimation.rule_matcher-classes)

  + [RuleMatchingEngine](#snakesee.estimation.rule_matcher.RuleMatchingEngine)

    - [Functions](#snakesee.estimation.rule_matcher.RuleMatchingEngine-functions)

      * [\_\_init\_\_](#snakesee.estimation.rule_matcher.RuleMatchingEngine.__init__)
      * [find\_best\_match](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_best_match)
      * [find\_by\_code\_hash](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_by_code_hash)
      * [find\_similar](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_similar)
* [Functions](#snakesee.estimation.rule_matcher-functions)

  + [levenshtein\_distance](#snakesee.estimation.rule_matcher.levenshtein_distance)

# rule\_matcher

Rule matching utilities for fuzzy matching and code hash lookup.

## Classes[¶](#snakesee.estimation.rule_matcher-classes "Permanent link")

### RuleMatchingEngine [¶](#snakesee.estimation.rule_matcher.RuleMatchingEngine "Permanent link")

Matches rules by name similarity and code hash.

Used to find timing data for renamed rules or similar rules
when exact matches aren't available.

Source code in `snakesee/estimation/rule_matcher.py`

|  |  |
| --- | --- |
| ``` 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 ``` | ``` class RuleMatchingEngine:     """Matches rules by name similarity and code hash.      Used to find timing data for renamed rules or similar rules     when exact matches aren't available.     """      def __init__(self, max_distance: int = 3) -> None:         """Initialize the matcher.          Args:             max_distance: Maximum Levenshtein distance for fuzzy matches.         """         self.max_distance = max_distance      def find_by_code_hash(         self,         rule: str,         code_hash_to_rules: dict[str, set[str]],         known_rules: set[str],     ) -> str | None:         """Find a rule with matching code hash.          When multiple rules share the same code hash and are in known_rules,         returns the lexicographically smallest rule name for deterministic behavior.          Args:             rule: Rule name to look up.             code_hash_to_rules: Mapping of code hashes to rule sets.             known_rules: Set of rules with available stats.          Returns:             Name of matching rule (lexicographically smallest if multiple),             or None if not found.         """         for _hash, rules in code_hash_to_rules.items():             if rule in rules:                 # Find all candidate rules that match criteria                 candidates = {r for r in rules if r != rule and r in known_rules}                 if candidates:                     # Return lexicographically smallest for deterministic selection                     return min(candidates)         return None      def find_similar(         self,         rule: str,         known_rules: set[str],         max_distance: int | None = None,     ) -> tuple[str, int] | None:         """Find similar rule by Levenshtein distance.          When multiple rules have the same distance, returns the lexicographically         smallest one for deterministic behavior.          Args:             rule: Rule name to match.             known_rules: Set of rules to search.             max_distance: Maximum distance (uses instance default if None).          Returns:             Tuple of (matched_rule, distance), or None if no match.         """         if max_distance is None:             max_distance = self.max_distance          best_match: str | None = None         best_distance = max_distance + 1          for known_rule in known_rules:             distance = levenshtein_distance(rule, known_rule)             # Prefer lower distance, then lexicographically smaller name for ties             if distance < best_distance or (                 distance == best_distance and best_match is not None and known_rule < best_match             ):                 best_distance = distance                 best_match = known_rule          if best_match is not None and best_distance <= max_distance:             return best_match, best_distance          return None      def find_best_match(         self,         rule: str,         code_hash_to_rules: dict[str, set[str]],         rule_stats: dict[str, RuleTimingStats],         max_distance: int | None = None,     ) -> tuple[str, RuleTimingStats] | None:         """Find the best matching rule using code hash then fuzzy matching.          Args:             rule: Rule name to match.             code_hash_to_rules: Mapping of code hashes to rule sets.             rule_stats: Available rule statistics.             max_distance: Maximum Levenshtein distance.          Returns:             Tuple of (matched_rule, stats), or None if no match.         """         known_rules = set(rule_stats.keys())          # Try code hash first (exact code = renamed rule)         hash_match = self.find_by_code_hash(rule, code_hash_to_rules, known_rules)         if hash_match is not None:             return hash_match, rule_stats[hash_match]          # Fall back to fuzzy name matching         similar = self.find_similar(rule, known_rules, max_distance)         if similar is not None:             matched_rule, _distance = similar             return matched_rule, rule_stats[matched_rule]          return None ``` |

#### Functions[¶](#snakesee.estimation.rule_matcher.RuleMatchingEngine-functions "Permanent link")

##### \_\_init\_\_ [¶](#snakesee.estimation.rule_matcher.RuleMatchingEngine.__init__ "Permanent link")

```
__init__(max_distance: int = 3) -> None
```

Initialize the matcher.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `max_distance` | `int` | Maximum Levenshtein distance for fuzzy matches. | `3` |

Source code in `snakesee/estimation/rule_matcher.py`

|  |  |
| --- | --- |
| ``` 49 50 51 52 53 54 55 ``` | ``` def __init__(self, max_distance: int = 3) -> None:     """Initialize the matcher.      Args:         max_distance: Maximum Levenshtein distance for fuzzy matches.     """     self.max_distance = max_distance ``` |

##### find\_best\_match [¶](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_best_match "Permanent link")

```
find_best_match(rule: str, code_hash_to_rules: dict[str, set[str]], rule_stats: dict[str, RuleTimingStats], max_distance: int | None = None) -> tuple[str, RuleTimingStats] | None
```

Find the best matching rule using code hash then fuzzy matching.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `rule` | `str` | Rule name to match. | *required* |
| `code_hash_to_rules` | `dict[str, set[str]]` | Mapping of code hashes to rule sets. | *required* |
| `rule_stats` | `dict[str, [RuleTimingStats](../index.html#snakesee.models.RuleTimingStats "RuleTimingStats            dataclass    (snakesee.models.RuleTimingStats)")]` | Available rule statistics. | *required* |
| `max_distance` | `int | None` | Maximum Levenshtein distance. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `tuple[str, [RuleTimingStats](../index.html#snakesee.models.RuleTimingStats "RuleTimingStats            dataclass    (snakesee.models.RuleTimingStats)")] | None` | Tuple of (matched\_rule, stats), or None if no match. |

Source code in `snakesee/estimation/rule_matcher.py`

|  |  |
| --- | --- |
| ``` 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 ``` | ``` def find_best_match(     self,     rule: str,     code_hash_to_rules: dict[str, set[str]],     rule_stats: dict[str, RuleTimingStats],     max_distance: int | None = None, ) -> tuple[str, RuleTimingStats] | None:     """Find the best matching rule using code hash then fuzzy matching.      Args:         rule: Rule name to match.         code_hash_to_rules: Mapping of code hashes to rule sets.         rule_stats: Available rule statistics.         max_distance: Maximum Levenshtein distance.      Returns:         Tuple of (matched_rule, stats), or None if no match.     """     known_rules = set(rule_stats.keys())      # Try code hash first (exact code = renamed rule)     hash_match = self.find_by_code_hash(rule, code_hash_to_rules, known_rules)     if hash_match is not None:         return hash_match, rule_stats[hash_match]      # Fall back to fuzzy name matching     similar = self.find_similar(rule, known_rules, max_distance)     if similar is not None:         matched_rule, _distance = similar         return matched_rule, rule_stats[matched_rule]      return None ``` |

##### find\_by\_code\_hash [¶](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_by_code_hash "Permanent link")

```
find_by_code_hash(rule: str, code_hash_to_rules: dict[str, set[str]], known_rules: set[str]) -> str | None
```

Find a rule with matching code hash.

When multiple rules share the same code hash and are in known\_rules,
returns the lexicographically smallest rule name for deterministic behavior.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `rule` | `str` | Rule name to look up. | *required* |
| `code_hash_to_rules` | `dict[str, set[str]]` | Mapping of code hashes to rule sets. | *required* |
| `known_rules` | `set[str]` | Set of rules with available stats. | *required* |

Returns:

| Type | Description |
| --- | --- |
| `str | None` | Name of matching rule (lexicographically smallest if multiple), |
| `str | None` | or None if not found. |

Source code in `snakesee/estimation/rule_matcher.py`

|  |  |
| --- | --- |
| ``` 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 ``` | ``` def find_by_code_hash(     self,     rule: str,     code_hash_to_rules: dict[str, set[str]],     known_rules: set[str], ) -> str | None:     """Find a rule with matching code hash.      When multiple rules share the same code hash and are in known_rules,     returns the lexicographically smallest rule name for deterministic behavior.      Args:         rule: Rule name to look up.         code_hash_to_rules: Mapping of code hashes to rule sets.         known_rules: Set of rules with available stats.      Returns:         Name of matching rule (lexicographically smallest if multiple),         or None if not found.     """     for _hash, rules in code_hash_to_rules.items():         if rule in rules:             # Find all candidate rules that match criteria             candidates = {r for r in rules if r != rule and r in known_rules}             if candidates:                 # Return lexicographically smallest for deterministic selection                 return min(candidates)     return None ``` |

##### find\_similar [¶](#snakesee.estimation.rule_matcher.RuleMatchingEngine.find_similar "Permanent link")

```
find_similar(rule: str, known_rules: set[str], max_distance: int | None = None) -> tuple[str, int] | None
```

Fin