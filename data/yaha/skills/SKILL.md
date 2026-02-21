---
name: yaha
description: Yaha is a high-performance Chinese word segmentation tool designed for speed and flexibility.
homepage: https://github.com/jannson/yaha
---

# yaha

## Overview

Yaha is a high-performance Chinese word segmentation tool designed for speed and flexibility. Unlike many traditional segmenters, it avoids memory-heavy Trie tree structures and instead uses a maximum probability path algorithm (Dijkstra/Dynamic Programming). It is particularly effective for users who need to "define" their own segmentation rules through a four-stage process, allowing for the integration of custom regex, name prefixes, and location suffixes. Beyond simple segmentation, it includes a "wordmaker" module for discovering new vocabulary in large datasets using MapReduce-like logic.

## Core Usage Patterns

### Basic Segmentation
Initialize the `Cuttor` to process Chinese strings. Yaha supports three primary modes:

*   **Exact Mode**: Attempts to find the most reasonable segmentation. Best for general text analysis.
*   **Full Mode**: Outputs all possible words from the dictionary found in the sentence. High recall, but contains ambiguity.
*   **Search Engine Mode**: Based on Exact mode, but further segments long words to improve search indexing recall.

```python
import yaha
cuttor = yaha.Cuttor()

# Exact mode (default)
words = cuttor.cut("哑哈中文分词更快更准确")
print(list(words))
```

### Customization via Stages
Yaha allows intervention at four distinct stages of the segmentation process:
1.  **Stage 1**: Pre-segmentation of non-Chinese characters (numbers, English) using regex.
2.  **Stage 2**: Pre-scanning to inject specific word candidates and probabilities before graph creation.
3.  **Stage 3**: Graph creation using dictionary probabilities and pattern matching (e.g., person names).
4.  **Stage 4**: Post-processing of "un-segmented" characters or path selection based on custom heuristics (like part-of-speech).

### New Word Discovery (Wordmaker)
For domain-specific corpora, use the independent `wordmaker` module (formerly `seqword.cpp`) to identify professional terms, names, or locations not found in standard dictionaries.
*   Supports multi-threading.
*   Capable of processing 50MB+ of text efficiently.
*   Uses a Maximum Entropy algorithm for discovery.

### Text Analysis Tools
Yaha provides built-in utilities for high-level text processing:
*   **Keyword Extraction**: Identify the most relevant terms in a document.
*   **Summarization**: Generate a concise summary of a large text block.
*   **Spelling Correction**: Correct user input errors, commonly used in search interfaces.

## Expert Tips
*   **Memory Efficiency**: If you are constrained by RAM, Yaha is a superior alternative to Jieba as it does not load a Trie tree.
*   **Dictionary Customization**: While Yaha supports user dictionaries, the most effective way to handle domain-specific text is to run the `wordmaker` on your corpus first and then add the discovered terms to the segmenter.
*   **Search Optimization**: Use the "Alternative Path" feature to generate multiple high-probability segmentation routes. This allows you to use external metadata (like POS tagging) to pick the absolute best path for your specific use case.

## Reference documentation
- [Yaha Readme](./references/github_com_jannson_yaha.md)
- [Yaha Master Tree](./references/github_com_jannson_yaha_tree_master_extra.md)