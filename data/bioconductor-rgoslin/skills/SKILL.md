---
name: bioconductor-rgoslin
description: This tool parses, validates, and normalizes lipid shorthand nomenclature using the Goslin grammars. Use when user asks to standardize lipid names across different databases, validate lipid nomenclature, or extract structural information and chemical properties from lipid strings.
homepage: https://bioconductor.org/packages/release/bioc/html/rgoslin.html
---


# bioconductor-rgoslin

name: bioconductor-rgoslin
description: Parse, validate, and normalize lipid shorthand nomenclature using the Goslin grammars. Use this skill when you need to convert lipid names between different dialects (LIPID MAPS, SwissLipids, HMDB), validate if a lipid name is correctly formatted, or extract structural information (fatty acid chains, adducts, mass, sum formula) from lipid strings in R.

# bioconductor-rgoslin

## Overview
The `rgoslin` package provides an R interface to the "Grammar of Succinct Lipid Nomenclatures" (Goslin). It is used to standardize lipid names into a common shorthand nomenclature. This is essential for lipidomics workflows where data from different sources or databases (like HMDB or LIPID MAPS) must be integrated or compared.

## Core Functions

### 1. List Supported Grammars
Check which nomenclature systems are available for parsing.
```R
library(rgoslin)
listAvailableGrammars()
# Returns: "Shorthand2020", "Goslin", "FattyAcids", "LipidMaps", "SwissLipids", "HMDB"
```

### 2. Validate Lipid Names
Check if a string is a valid lipid name according to any supported grammar.
```R
isValidLipidName("PC 32:1")
# Returns TRUE or FALSE
```

### 3. Parse Lipid Names
The primary function `parseLipidNames` returns a data frame containing normalized names, structural levels, and chemical properties.

**Single Name:**
```R
df <- parseLipidNames("PC 32:1")
```

**Multiple Names:**
```R
lipids <- c("PC 32:1", "LPC 34:1", "TG(18:1_18:0_16:1)")
df_multiple <- parseLipidNames(lipids)
```

**Specific Grammar:**
If you know the source of the names, specifying the grammar is faster and more accurate.
```R
df_maps <- parseLipidNames("TG(16:1(5E)/18:0/20:2(3Z,6Z))", grammar = "LipidMaps")
```

## Common Workflows

### Normalizing Names for Integration
When merging datasets with inconsistent naming (e.g., "PC(32:1)" vs "PC 32:1"), use `rgoslin` to generate a `Normalized.Name`.
```R
raw_names <- c("PC(16:0/16:1)", "PC 32:1")
normalized_df <- parseLipidNames(raw_names)
# Use normalized_df$Normalized.Name for merging
```

### Extracting Structural Details
The output data frame contains detailed columns for:
- **Total Composition:** `Total.C`, `Total.DB`, `Total.OH`
- **Chemical Properties:** `Mass`, `Sum.Formula`
- **Classification:** `Lipid.Maps.Category`, `Lipid.Maps.Main.Class`
- **Fatty Acid Details:** Columns prefixed with `FA1.`, `FA2.`, etc. (e.g., `FA1.C`, `FA1.DB`)

### Handling Adducts
`rgoslin` can parse names containing adduct information, populating `Adduct` and `Adduct.Charge` columns.
```R
parseLipidNames("PC 32:1 [M+H]+")
```

### Integration with lipidr
If using the `lipidr` package, `rgoslin` can be used to fix names that `lipidr` fails to parse, such as those with specific suffixes or updated headgroup names (e.g., converting `Sa1P` to `SPBP`).

## Tips
- **Performance:** If processing large vectors of names, always specify the `grammar` if known to avoid the overhead of testing every parser.
- **Column Names:** Note that `rgoslin` 2.0+ uses dots (`.`) in column names (e.g., `Normalized.Name`) instead of spaces to make data frame access easier.
- **Missing Values:** If a lipid is parsed at the "Species" level (e.g., `PC 32:1`), individual fatty acid columns (`FA1`, `FA2`) will be `NA` because the specific sn-positions are not defined.

## Reference documentation
- [Using rgoslin to parse and normalize lipid nomenclature](./references/introduction.md)
- [Using rgoslin to parse and normalize lipid nomenclature](./references/introduction.Rmd)