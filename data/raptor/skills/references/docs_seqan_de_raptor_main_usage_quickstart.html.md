|  |
| --- |
| Raptor 4.0.0-rc.1  A fast and space-efficient pre-filter |

Loading...

Searching...

No Matches

Quickstart

### Table of Contents

* [What problems can be solved](#autotoc_md35)
* [Workflow](#autotoc_md36)
* [General decisions](#autotoc_md37)
  + [HIBF vs IBF](#hibf_vs_ibf)
  + [Choosing window and k-mer size](#usage_w_vs_k)
    - [(w,k) minimisers vs (k,k) canonical k-mers](#autotoc_md38)
    - [(w,k) minimisers](#autotoc_md39)
    - [(k,k) canonical k-mers](#autotoc_md40)

# What problems can be solved

* Approximate Membership Query (AMQ) based on k-mers
* Input are sequences. Also called samples/references/genomes/color. We use the term bin or user bin.
* Given a query sequence: Show all bins that possibly contain that sequence.
  + Either given a number of errors
  + Or given a percentage (e.g., 0.7 -> 70% of queried k-mers must be present in a bin)
* Does not model a colored de Bruijn graph:
  + ✔️ Given a k-mer: Tell to which color (bin) it belongs to
  + ❌ Given a color (bin): Show all k-mers that belong to this color (bin)

# Workflow

* **HIBF** [`raptor prepare`] -> `raptor layout` -> `raptor build` -> `raptor search`
* **IBF** [`raptor prepare`] -> `raptor build` -> `raptor search`

# General decisions

## HIBF vs IBF

Recommendation: HIBF

Cases in which to consider the IBF:

* Evenly sized bins
* Small number of bins (≤ 128)

Click to see an HIBF / IBF comparison.

Note
:   The used data set is the **worst case** for the HIBF. In reality, the index size is usually smaller than the corresponding IBF, and build times of the HIBF are much closer to IBF build times.

## Choosing window and k-mer size

### (w,k) minimisers vs (k,k) canonical k-mers

|  | (k,k) | (w,k) |
| --- | --- | --- |
| Index size | ⬆️ | ⬇️ |
| Runtime | ⬆️ | ⬇️ |
| RAM usage | ⬆️ | ⬇️ |
| Thresholding¹ | Exact | Heuristic |

¹ When searching with a given number of errors.

* (w,k) minimisers reduce the number of values to process by roughly \(\frac{w - k + 2}{2}\).
* (w,k) minimisers have a slightly lower accuracy than (k,k). However, the loss of accuracy mainly stems from false positives, not false negatives.

Recommendation: (w,k) with gentle compression (w-k=4)

Click to see the differences of (w,k) and (k,k) on different aspects.

### (w,k) minimisers

Requirements:

* `w > k`
* `w ≤ query length`

Recommendation:

* `w - k = 4`
* `w << query length`

Examples:

* query length 100: `w = 24`, `k = 20`
* query length 250: `w = 28`, `k = 24`

Also see the figure in [usage\_w\_vs\_k\_figure](#usage_w_vs_k_figure).

### (k,k) canonical k-mers

Requirements:

* `k ≤ query length`
* k-mer counting lemma satisfied, when searching with a given number of errors.

Recommendation:

* `k << query length`

Examples (for two errors):

* query length 100: `k = 20`
* query length 250: `k = 32`

Depending on the number of errors that should be accounted for when searching, the `kmer-size` (`k`) has to be chosen such that the k-mer lemma still has a positive threshold.

**K-mer counting lemma**: For a given `k` and number of errors `e`, there are \(k\_p = |p| - k + 1\) many k-mers in the pattern `p` and an approximate occurrence of `p` in text `T` has to share at least \(t = (k\_p - k \cdot e)\) k-mers.

For example, when searching reads of length 100 and allowing 4 errors, k has to be at most 20 (100 − 20 + 1 − 4 · 20 = 1).

Furthermore, k shall be such that a random k-mer match in the database is unlikely. For example, we chose k = 32 for the RefSeq data set. In general, there is no drawback in choosing the (currently supported) maximum k of 32, as long as the aforementioned requirements are fulfilled.

[Hide me](doxygen_crawl.html)

* Version:* * Generated on Mon Mar 23 2026 14:04:40 for Raptor by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.10.0