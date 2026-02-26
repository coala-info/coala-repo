---
name: r-prettyunits
description: The r-prettyunits package formats quantities like time, bytes, and numbers into human-readable strings. Use when user asks to format time intervals, convert bytes to readable sizes, add SI prefixes to numbers, or generate human-friendly color names.
homepage: https://cloud.r-project.org/web/packages/prettyunits/index.html
---


# r-prettyunits

## Overview
The `prettyunits` package provides a collection of tools to format quantities into human-readable strings. It is particularly useful for logging, progress bars, reporting, and UI elements where raw numeric values (like 1337000 seconds) are difficult for humans to parse quickly.

## Installation
Install the stable version from CRAN:
```r
install.packages("prettyunits")
```

## Main Functions

### Time Intervals
Convert numeric values or `difftime` objects into readable durations.
*   `pretty_ms(ms)`: Formats milliseconds.
*   `pretty_sec(sec)`: Formats seconds.
*   `pretty_dt(dt)`: Formats `difftime` objects.
*   **Compact mode**: Use `compact = TRUE` to get approximate, shorter strings (e.g., "~2m" instead of "2m 13.7s").

### Vague Time (Relative)
Use these for "time ago" style formatting or fuzzy intervals.
*   `time_ago(date)`: Returns strings like "moments ago", "14 minutes ago", or "a day ago".
*   `vague_dt(dt, format = c("default", "short", "terse"))`: Formats a `difftime` vaguely.

### Data Sizes (Bytes)
*   `pretty_bytes(bytes)`: Automatically chooses the best unit (B, kB, MB, GB, etc.).
    ```r
    pretty_bytes(13333337) # "13.33 MB"
    ```

### Linear Quantities
*   `pretty_num(n)`: Adds SI prefixes (k, M, G, etc.) to large or small numbers.
    ```r
    pretty_num(1239437) # "1.24 M"
    pretty_num(0.001)   # "1 m"
    ```

### Formatting & Rounding
Unlike base R functions, these preserve trailing zeros to maintain consistent significant digits.
*   `pretty_round(x, digits)`: Rounds and keeps trailing zeros.
*   `pretty_signif(x, digits)`: Rounds to significant digits and keeps trailing zeros.
*   `pretty_p_value(p)`: Formats p-values, using `<0.0001` for very small values.

### Colors
*   `pretty_color(hex)`: Converts hex codes or color names to descriptive human names.
    ```r
    pretty_color("#123456") # "Prussian Blue"
    ```

## Workflows

### Prettifying a Data Frame
You can use `dplyr::across` to format multiple columns for a report:
```r
library(dplyr)
library(prettyunits)

df %>%
  mutate(
    file_size = pretty_bytes(size_in_bytes),
    runtime = pretty_sec(duration_seconds),
    p_val = pretty_p_value(p_value)
  )
```

### Customizing Significant Digits
Most functions allow control over precision:
```r
pretty_bytes(1337000, digits = 1) # "1.3 MB"
```

## Reference documentation
- [prettyunits README](./references/README.md)