# ditasic CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ditasic | Failed | image problem: the image has no R (Rscript missing), so the ditasic R script exits with status 127 before reading any input |

## ditasic

### Tool Description
Differential Taxon Abundance Subtraction and Intersection Counting for accurate profiling of metagenomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/ditasic:0.2--py37h470a237_0
- **Homepage**: https://rki_bioinformatics.gitlab.io/ditasic/
- **Package**: https://anaconda.org/channels/bioconda/packages/ditasic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ditasic/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ditasic -r REFPATH_FILE -a SIMILARITY_MATRIX -x COUNTS_S1 -n TOTAL_S1 [-y COUNTS_S2 -m TOTAL_S2] [options]

(The image has no Rscript, so --help cannot run; options taken from core/parameters.R in the image.)

Options:
  -r, --refs          taxa names file containing the absolute path to all considered taxa references
  -a, --Mat           path to the similarity_matrix.npy file (output of 'ditasic_matrix')
  -x, --counts_s1     mapped count vector of sample 1: sample.npy file (output of 'ditasic_mapping')
  -y, --counts_s2     mapped count vector of sample 2: sample.npy file (output of 'ditasic_mapping')
  -n, --N_s1          total vector of sample 1: total.npy file (output of 'ditasic_mapping')
  -m, --N_s2          total vector of sample 2: total.npy file (output of 'ditasic_mapping')
  -f, --filter        apply filtering to remove false-positive taxa (logical, default = F)
  -o, --output        name of the output file (default DiffAbund_Result.txt)
  -p, --pval_thres    p-value threshold for filtering (default = 0.05)
  -t, --min_thres     minimum number of reads to assign significant taxa existence (default = 0)
  -s, --seed          seed for sampling in empirical distributions (default = 1448)
```


## Metadata
- **Skill**: not generated
