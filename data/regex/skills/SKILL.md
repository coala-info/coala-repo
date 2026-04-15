---
name: regex
description: This tool identifies and manipulates specific patterns within text using a specialized syntax. Use when user asks to build or interpret patterns, clean data, validate structural formats like emails, or perform automated text editing.
homepage: https://github.com/ziishaned/learn-regex
metadata:
  docker_image: "quay.io/biocontainers/regex:2016.06.24--py36_1"
---

# regex

## Overview
Regular expressions (regex) are a specialized syntax used to identify specific patterns within text. This skill equips an agent with the procedural knowledge to build and interpret patterns ranging from simple character matches to complex conditional lookarounds. It is essential for tasks involving data cleaning, structural validation (like emails or usernames), and automated text editing where literal string matching is insufficient.

## Core Syntax Reference

### Meta Characters
- `.` : Matches any single character except a line break.
- `[ ]` : Character class. Matches any one character contained within the brackets (e.g., `[aeiou]`).
- `[^ ]` : Negated character class. Matches any character NOT contained within the brackets.
- `\` : Escapes a meta character to treat it as a literal (e.g., `\.` matches a period).

### Quantifiers (Repetitions)
- `*` : Matches 0 or more of the preceding element.
- `+` : Matches 1 or more of the preceding element.
- `?` : Matches 0 or 1 of the preceding element (makes it optional).
- `{n,m}` : Matches between `n` and `m` repetitions.

### Anchors
- `^` : Matches the start of the string or line.
- `$` : Matches the end of the string or line.

### Groups and Alternation
- `(xyz)` : Capturing group. Matches the exact sequence and remembers it.
- `(?:xyz)` : Non-capturing group. Groups characters without storing them for backreferencing.
- `|` : Alternation. Acts like a logical OR (e.g., `cat|dog`).

## Advanced Patterns

### Lookarounds
- `(?=...)` : Positive Lookahead. Matches a group after the main expression without including it in the result.
- `(?!...)` : Negative Lookahead. Matches only if the main expression is NOT followed by the specified group.
- `(?<=...)` : Positive Lookbehind. Matches a group before the main expression.
- `(?<!...)` : Negative Lookbehind. Matches only if the main expression is NOT preceded by the specified group.

### Shorthand Classes
- `\w` : Alphanumeric characters plus underscore `[A-Za-z0-9_]`.
- `\d` : Digits `[0-9]`.
- `\s` : Whitespace characters (spaces, tabs, line breaks).
- `\W`, `\D`, `\S` : The inverse of the above (non-word, non-digit, non-whitespace).

## Expert Tips and Best Practices

- **Greedy vs. Lazy**: By default, quantifiers like `*` and `+` are "greedy"—they match as much text as possible. Append a `?` (e.g., `.*?` or `.+?`) to make them "lazy," matching only the shortest possible string.
- **Character Range Efficiency**: Use ranges like `[a-z]` or `[0-9]` instead of listing every character.
- **Literal Periods**: Remember that `.` inside square brackets `[.]` is treated as a literal period and does not need a backslash.
- **Validation Logic**: When validating a full string (like a username), always wrap the pattern in anchors `^...$` to ensure the entire input matches the criteria, not just a substring.
- **Performance**: Use non-capturing groups `(?:...)` when you need to group elements for quantifiers or alternation but do not need to extract that specific part of the match.

## Reference documentation
- [Learn Regex the Easy Way](./references/github_com_ziishaned_learn-regex.md)