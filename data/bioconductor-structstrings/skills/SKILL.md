---
name: bioconductor-structstrings
description: The Structstrings package extends Biostrings to handle RNA secondary structure information using dot-bracket notation. Use when user asks to store RNA structures, validate dot-bracket strings, convert structures into base pairing tables, or calculate loop indices.
homepage: https://bioconductor.org/packages/release/bioc/html/Structstrings.html
---


# bioconductor-structstrings

## Overview
The `Structstrings` package extends the Biostrings infrastructure to support RNA secondary structure information. It primarily uses the dot-bracket notation (e.g., `((...))` ) to represent base pairing. The package provides efficient C-based implementations for converting these notations into tabular formats for structural analysis and ensures the validity of pairing information (e.g., matching brackets) upon object creation.

## Core Classes
- `DotBracketString` / `DotBracketStringSet`: For storing structure strings. Supports multiple bracket types: `()`, `<>`, `[]`, and `{}`.
- `DotBracketDataFrame`: A specialized DataFrame containing columns: `pos`, `forward`, `reverse`, `character`, and optionally `base`.
- `StructuredRNAStringSet`: A container that pairs an `RNAStringSet` with a `DotBracketStringSet`.

## Key Workflows

### 1. Creating and Validating Structures
You can create structure objects from character vectors. The package automatically validates that all brackets are correctly closed.
```r
library(Structstrings)

# Create a single structure
dbs <- DotBracketString("((((....))))")

# Create a set of structures (different bracket types are supported)
dbss <- DotBracketStringSet(c("((..))", "<<..>>", "[[..]]"))

# Convert between annotation types (e.g., convert type 2 '<' to type 1 '(')
converted <- convertAnnotation(dbss, from = 2L, to = 1L)
```

### 2. Analyzing Base Pairs and Loops
To perform in-depth analysis, convert the string representation into a table or calculate loop indices.
```r
# Get a base pairing table (DotBracketDataFrame)
db_df_list <- getBasePairing(dbs)
# Access the first element's table
df <- db_df_list[[1L]]

# Get loop indices to identify structural elements
loops <- getLoopIndices(dbs, bracket.type = 1L)
```

### 3. Reconstructing Dot-Bracket Strings
You can generate or "clean" dot-bracket strings from a pairing table. This is useful for simplifying complex pseudoknots.
```r
# Reconstruct string from a DotBracketDataFrame
# force = TRUE ensures the string is recalculated from pairing logic
new_dbs <- getDotBracket(db_df_list, force = TRUE)
```

### 4. Integrated Sequence and Structure
Use `StructuredRNAStringSet` to keep nucleotide sequences and their corresponding structures synchronized.
```r
# Assuming nseq is an RNAStringSet and dbs is a DotBracketStringSet
sdbs <- StructuredRNAStringSet(nseq, dbs)

# Access the structure part
db_part <- dotbracket(sdbs)

# Get base pairing table including the actual nucleotides
# return.sequence = TRUE adds the 'base' column
full_df <- getBasePairing(sdbs, return.sequence = TRUE)
```

## Tips and Best Practices
- **Validation Errors**: If `DotBracketString()` throws an error, it means the input string has unmatched brackets or invalid characters.
- **Efficiency**: `getBasePairing()` is implemented in C. For very large sets, setting `return.sequence = FALSE` (the default) is faster as it avoids copying sequence data into the data frame.
- **Annotation Order**: When using `getDotBracket()` on complex structures, the package prioritizes bracket types in the order: `()`, then `<>`, then `[]`, then `{}`. This may result in a "simplified" version of the original string if multiple types were used inconsistently.

## Reference documentation
- [Structstrings](./references/Structstrings.md)