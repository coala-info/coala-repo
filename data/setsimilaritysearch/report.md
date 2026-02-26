# setsimilaritysearch CWL Generation Report

## setsimilaritysearch_all_pairs.py

### Tool Description
Find all pairs of sets with similarities over a given threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/setsimilaritysearch:1.0.0
- **Homepage**: https://github.com/ekzhu/SetSimilaritySearch
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/setsimilaritysearch/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ekzhu/SetSimilaritySearch
- **Stars**: N/A
### Original Help Text
```text
usage: all_pairs.py [-h] --input-sets INPUT_SETS [INPUT_SETS ...]
                    --output-pairs OUTPUT_PAIRS
                    [--similarity-func {jaccard,cosine,containment,containment_min}]
                    [--similarity-threshold SIMILARITY_THRESHOLD]
                    [--reversed-tuple REVERSED_TUPLE] [--sample-k SAMPLE_K]

Find all pairs of sets with similarities over a given threshold.

options:
  -h, --help            show this help message and exit
  --input-sets INPUT_SETS [INPUT_SETS ...]
                        Input flattened set files with each line a (SetID
                        Token) tuple: 1 file for finding self all pairs (self-
                        join); 2 files for finding cross-collection all pairs
                        (join).
  --output-pairs OUTPUT_PAIRS
                        Output file with each line a (SetID_X, SetID_Y,
                        Size_X, Size_Y, Similarity) tuple.
  --similarity-func {jaccard,cosine,containment,containment_min}
  --similarity-threshold SIMILARITY_THRESHOLD
  --reversed-tuple REVERSED_TUPLE
                        Whether the input tuples are reversed i.e. (Token
                        SetID).
  --sample-k SAMPLE_K   The number of sampled sets from the second file to use
                        as queries; default use all sets.
```

