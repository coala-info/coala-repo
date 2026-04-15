---
name: grinder
description: Angle Grinder is a high-performance command-line tool used to parse, transform, and aggregate logs using a functional piped syntax. Use when user asks to slice and dice logs, parse JSON or logfmt data, extract fields from raw text, or perform live-updating aggregations on log streams.
homepage: https://github.com/rcoh/angle-grinder
metadata:
  docker_image: "biocontainers/grinder:v0.5.4-5-deb_cv1"
---

# grinder

## Overview

Angle Grinder (`agrind`) is a high-performance command-line tool designed for "slicing and dicing" logs. It provides a functional programming-like syntax to transform raw text into structured data through a series of piped operators. It is capable of processing millions of rows per second and provides a live-updating terminal UI for aggregations, making it perfect for immediate troubleshooting and data exploration.

## Core Syntax

The basic structure of a grinder command is:
`agrind '<filters> | operator1 | operator2 | aggregator'`

### Filters
Filters select which lines enter the pipeline.
- `*`: Match all lines.
- `error`: Case-insensitive match for "error".
- `"Error"`: Case-sensitive match for "Error".
- `(ERROR OR WARN) AND NOT staging`: Boolean logic with grouping.

### Parsing Operators
- `json`: Automatically parses JSON objects. Access nested fields with dot notation (e.g., `metadata.user_id`).
- `logfmt`: Parses key-value pairs (e.g., `level=info msg="started"`).
- `parse "* - * [*] \"*\"" as ip, user, ts, req`: Uses wildcards to extract specific patterns into named fields.
- `split(field) on "," as array`: Breaks a string into an array.

### Aggregation Operators
- `count by field`: Groups and counts occurrences.
- `sum(field)`, `avg(field)`, `min(field)`, `max(field)`: Standard math aggregations.
- `percentile(field, 95)`: Calculates the 95th percentile.
- `count_distinct(field)`: Counts unique values.
- `sort by _count desc`: Orders the results (often used after a count).

## Expert Tips and Patterns

### Handling Non-Matching Lines
By default, the `parse` operator drops lines that do not match the pattern. Use the `nodrop` flag to keep them:
`agrind '* | parse "ID: *" as id nodrop'`

### Preserving Data Types
Grinder attempts to convert parsed strings to numbers automatically. To prevent this (e.g., for IDs with leading zeros), use `noconvert`:
`agrind '* | parse "code=*" as code noconvert'`

### Working with Nested JSON
You can access deep structures or specific array indices directly:
`agrind '* | json | count by servers[0].host_name'`

### Escaping Special Characters
If a field name contains spaces or periods, wrap it in brackets and quotes:
`agrind '* | json | sum(["response.time.ms"])'`

### Using Aliases
For common log formats, use built-in aliases to skip manual parsing:
`agrind '* | apache | count by status'`

## Reference documentation
- [Angle Grinder README](./references/github_com_rcoh_angle-grinder.md)