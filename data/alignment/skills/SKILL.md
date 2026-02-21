---
name: alignment
description: "A tool for building or fetching alignment container images (Note: The provided text is an execution log indicating a failed SIF build from an OCI/Docker source rather than standard help documentation)."
homepage: https://github.com/eseraygun/python-alignment
---

# alignment

## Overview
The `alignment` library is a native Python tool designed for pairwise sequence alignment across any data type that can be tokenized. While most alignment tools are hard-coded for DNA or protein sequences, this library uses a vocabulary-based encoding system to handle arbitrarily large alphabets. It supports both global alignment (Needleman-Wunsch style) and local alignment (Smith-Waterman style), making it highly effective for natural language processing, log analysis, or pattern matching in non-standard datasets.

## Usage Guidance

### Core Workflow
To align two sequences, follow this procedural sequence:
1.  **Tokenization**: Convert your input data into a list of tokens (e.g., using `.split()` for sentences).
2.  **Encoding**: Use a `Vocabulary` object to map these tokens to integers. This is required before passing data to the aligner.
3.  **Scoring Configuration**: Define a `SimpleScoring` object with specific values for matches and mismatches.
4.  **Alignment**: Initialize a `GlobalSequenceAligner` or `LocalSequenceAligner` with a gap penalty, then run the `align` method.
5.  **Decoding**: Convert the resulting encoded alignment back into human-readable format using the vocabulary.

### Implementation Example
```python
from alignment.sequence import Sequence
from alignment.vocabulary import Vocabulary
from alignment.sequencealigner import SimpleScoring, GlobalSequenceAligner

# 1. Prepare sequences
seq_a = Sequence('the quick brown fox'.split())
seq_b = Sequence('the fast brown fox'.split())

# 2. Encode via Vocabulary
v = Vocabulary()
a_enc = v.encodeSequence(seq_a)
b_enc = v.encodeSequence(seq_b)

# 3. Configure Scoring (match, mismatch) and Aligner (scoring, gap_penalty)
scoring = SimpleScoring(2, -1)
aligner = GlobalSequenceAligner(scoring, -2)

# 4. Align
score, encodeds = aligner.align(a_enc, b_enc, backtrace=True)

# 5. Decode and Inspect
for encoded in encodeds:
    alignment = v.decodeSequenceAlignment(encoded)
    print(alignment)
    print(f"Score: {alignment.score}")
    print(f"Identity: {alignment.percentIdentity()}%")
```

### Expert Tips
- **Backtrace**: Always set `backtrace=True` in the `align()` method if you need to visualize the alignment or calculate identity; otherwise, the tool only returns the numerical score.
- **Gap Penalties**: The gap penalty in the Aligner constructor should typically be a negative value. A larger negative value (e.g., -5 vs -1) makes the aligner more "expensive" to open gaps, favoring substitutions over insertions/deletions.
- **Large Alphabets**: Because the `Vocabulary` object builds its map dynamically, you can align sequences of complex objects as long as they are hashable.
- **Local vs. Global**: Use `GlobalSequenceAligner` when you expect the sequences to be similar across their entire length. Use `LocalSequenceAligner` when looking for a shared subsequence within two significantly different sequences.

## Reference documentation
- [python-alignment GitHub Overview](./references/github_com_eseraygun_python-alignment.md)
- [Bioconda Alignment Package Details](./references/anaconda_org_channels_bioconda_packages_alignment_overview.md)