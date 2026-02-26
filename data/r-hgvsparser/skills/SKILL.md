---
name: r-hgvsparser
description: This tool parses, validates, and builds variant descriptor strings compliant with the Human Genome Variation Society standard in R. Use when user asks to parse HGVS strings into structured data, build HGVS-formatted strings from variant components, or validate genomic, transcript, and protein variant nomenclature.
homepage: https://cran.r-project.org/web/packages/hgvsparser/index.html
---


# r-hgvsparser

name: r-hgvsparser
description: Parsing and building variant descriptor strings compliant with the Human Genome Variation Society (HGVS) standard in R. Use this skill when you need to validate, decompose, or construct HGVS-formatted genomic, transcript, or protein variant strings (e.g., "NM_000059.3:c.270_282del", "p.His1083Arg").

## Overview

The `hgvsparser` package provides tools to handle HGVS variant nomenclature within the R environment. It allows users to parse complex variant strings into structured data frames and build compliant HGVS strings from variant components. This is essential for bioinformatics workflows involving clinical genetics, variant annotation, and database interoperability.

## Installation

```R
# Install from CRAN
install.packages("hgvsparser")

# Alternatively, install the development version from GitHub
# install.packages("devtools")
# devtools::install_github("VariantEffect/hgvsParseR")
```

## Main Functions

### Parsing HGVS Strings
The primary function for decomposing HGVS strings is `hgvs_parse()`. It breaks down a string into its constituent parts (reference sequence, type, position, and change).

```R
library(hgvsparser)

# Parse a single variant
variant <- "NM_000059.3:c.270_282del"
parsed_data <- hgvs_parse(variant)

# Parse a vector of variants
variants <- c("NM_000059.3:c.270_282del", "NP_000050.2:p.His1083Arg")
parsed_df <- hgvs_parse(variants)
```

### Building HGVS Strings
Use `hgvs_build()` to create compliant strings from structured data.

```R
# Example data frame for building
df <- data.frame(
  ref_seq = "NM_000059.3",
  type = "c",
  pos_start = 270,
  pos_end = 282,
  variant_type = "del"
)

hgvs_string <- hgvs_build(df)
```

## Workflows

### Data Cleaning and Validation
When dealing with large datasets of variants, use `hgvs_parse()` to identify malformed strings. Rows that fail to parse will typically return `NA` or empty fields in the resulting data frame, allowing for easy filtering.

```R
results <- hgvs_parse(my_variant_list)
valid_variants <- results[!is.na(results$ref_seq), ]
```

### Converting Between Formats
You can use the parsed components to map HGVS coordinates to other formats (like VCF-style CHROM, POS, REF, ALT) by extracting the `pos_start`, `ref_allele`, and `alt_allele` columns from the parsed output.

## Tips
- **Reference Sequences**: Ensure your strings include the reference accession (e.g., `NM_` or `NP_`) for the most reliable parsing.
- **Supported Types**: The parser handles coding (`c.`), genomic (`g.`), mitochondrial (`m.`), non-coding RNA (`n.`), and protein (`p.`) variants.
- **Complex Indels**: For complex insertions/deletions, check the `pos_start` and `pos_end` columns to ensure the range is captured correctly.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)