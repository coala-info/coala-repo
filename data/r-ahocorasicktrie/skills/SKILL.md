---
name: r-ahocorasicktrie
description: "Aho-Corasick is an optimal algorithm for finding many     keywords in a text. It can locate all matches in a text in O(N+M) time; i.e.,     the time needed scales linearly with the number of keywords (N) and the size of     the text (M). Compare this to the naive approach which takes O(N*M) time to loop     through each pattern and scan for it in the text. This implementation builds the     trie (the generic name of the data structure) and runs the search in a single     function call. If you want to search multiple texts with the same trie, the     function will take a list or vector of texts and return a list of matches to     each text. By default, all 128 ASCII characters are allowed in both the keywords     and the text. A more efficient trie is possible if the alphabet size can be     reduced. For example, DNA sequences use at most 19 distinct characters and     usually only 4; protein sequences use at most 26 distinct characters and usually     only 20. UTF-8 (Unicode) matching is not currently supported.</p>"
homepage: https://cloud.r-project.org/web/packages/AhoCorasickTrie/index.html
---

# r-ahocorasicktrie

name: r-ahocorasicktrie
description: High-performance multi-pattern string matching in R using the Aho-Corasick algorithm. Use this skill when you need to search for a large number of keywords (patterns) within one or more long target texts. It is significantly faster than nested loops or multiple `grep` calls, scaling linearly with the size of the input. Ideal for bioinformatics (DNA/protein sequences) and ASCII text mining.

# r-ahocorasicktrie

## Overview
The `AhoCorasickTrie` package provides an R interface to the Aho-Corasick algorithm, which locates all occurrences of a set of keywords in a text in $O(N+M)$ time. This is optimal compared to the $O(N*M)$ complexity of naive searches. The implementation builds a trie and performs the search in a single efficient step.

## Installation
Install the package from CRAN:
```R
install.packages("AhoCorasickTrie")
```

## Core Functionality

### AhoCorasickSearch
The primary function is `AhoCorasickSearch()`. It handles both the trie construction and the search process.

**Key Parameters:**
- `keywords`: A character vector of patterns to search for.
- `text`: A character vector of one or more texts to search within.
- `alphabet`: The set of allowed characters. Options: `"ascii"` (default), `"dna"`, `"protein"`, or a custom string of unique characters.
- `groupByText`: If `TRUE` (default), returns a list where each element corresponds to a text. If `FALSE`, returns a list where each element corresponds to a keyword.
- `iterationFill`: If `TRUE`, fills in the keyword for every match (useful for converting to a data frame).

## Workflows

### Basic Multi-Keyword Search
Use this for standard text processing where you have a list of terms to find in a document.
```R
library(AhoCorasickTrie)
keywords <- c("apple", "banana", "orange")
text <- "I have an apple and a banana in my basket."
results <- AhoCorasickSearch(keywords, text)
# Access matches for the first text
print(results[[1]])
```

### Processing Multiple Texts
Pass a vector of strings to the `text` parameter to search all of them using the same trie.
```R
texts <- c("The apple is red.", "The banana is yellow.")
results <- AhoCorasickSearch(keywords, texts)
# results[[1]] contains matches for the first string
# results[[2]] contains matches for the second string
```

### Optimized Bioinformatics Search
When working with DNA or Protein sequences, specify the alphabet to reduce the trie size and improve performance.
```R
dna_keywords <- c("ATG", "GCAA", "TTA")
dna_sequence <- "ATGCATGCATGC"
results <- AhoCorasickSearch(dna_keywords, dna_sequence, alphabet = "dna")
```

### Converting Results to Data Frames
To easily manipulate results, use `iterationFill = TRUE` and `rbind`:
```R
res_list <- AhoCorasickSearch(keywords, texts, iterationFill = TRUE)
res_df <- do.call(rbind, lapply(res_list, as.data.frame))
```

## Tips and Limitations
- **ASCII Only**: The package currently only supports 128-character ASCII. UTF-8/Unicode matching is not supported.
- **Memory Efficiency**: For very large keyword sets, ensure the `alphabet` is as small as possible (e.g., use `"dna"` instead of `"ascii"`) to minimize the memory footprint of the trie.
- **Case Sensitivity**: The search is case-sensitive. Pre-process your keywords and text with `tolower()` if case-insensitive matching is required.

## Reference documentation
- [AhoCorasickTrie README](./references/README.md)