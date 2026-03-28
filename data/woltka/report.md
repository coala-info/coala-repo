# woltka CWL Generation Report

## woltka_collapse

### Tool Description
Collapse a profile by feature mapping and/or hierarchy.

### Metadata
- **Docker Image**: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/qiyunzhu/woltka
- **Package**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qiyunzhu/woltka
- **Stars**: N/A
### Original Help Text
```text
Usage: woltka collapse [OPTIONS]

  Collapse a profile by feature mapping and/or hierarchy.

Options:
  -i, --input FILE     Path to input profile.  [required]
  -o, --output FILE    Path to output profile.  [required]
  -m, --map FILE       Mapping of source features to target features. Supports
                       many-to-many relationships.
  -d, --divide         Count each target feature as 1/k (k is the number of
                       targets mapped to a source). Otherwise, count as one.
  -f, --field INTEGER  Collapse x-th field of stratified features. For
                       example, "A|a" has fields 1 ("A") and 2 ("a").
  -e, --nested         Fields are nested (each field is a child of the
                       previous field). For example, "A_1" represents "1" of
                       "A".
  -s, --sep TEXT       Field separator for nested features (default: "_") or
                       otherwise (default: "|").
  -n, --names PATH     Names of target features to append to the output
                       profile.
  -h, --help           Show this message and exit.
```


## woltka_normalize

### Tool Description
Normalize a profile to fractions and/or by feature sizes.

### Metadata
- **Docker Image**: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/qiyunzhu/woltka
- **Package**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: woltka normalize [OPTIONS]

  Normalize a profile to fractions and/or by feature sizes.

Options:
  -i, --input FILE            Path to input profile.  [required]
  -o, --output FILE           Path to output profile.  [required]
  -z, --sizes FILE            Path to mapping of feature sizes, by which
                              values will be divided. If omitted, will divide
                              values by sum per sample.
  -s, --scale TEXT            Scale values by this factor. Accepts "k", "M"
                              suffixes.
  -d, --digits INTEGER RANGE  Round values to this number of digits after the
                              decimal point. If omitted, will keep decimal
                              precision of input profile.  [0<=x<=10]
  -h, --help                  Show this message and exit.
```


## woltka_filter

### Tool Description
Filter a profile by per-sample abundance.

### Metadata
- **Docker Image**: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/qiyunzhu/woltka
- **Package**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: woltka filter [OPTIONS]

  Filter a profile by per-sample abundance.

Options:
  -i, --input FILE               Path to input profile.  [required]
  -o, --output FILE              Path to output profile.  [required]
  -c, --min-count INTEGER RANGE  Per-sample minimum count threshold.  [x>=1]
  -p, --min-percent FLOAT        Per-sample minimum percentage threshold.
  -h, --help                     Show this message and exit.
```


## woltka_merge

### Tool Description
Merge multiple profiles into one profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/qiyunzhu/woltka
- **Package**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: woltka merge [OPTIONS]

  Merge multiple profiles into one profile.

Options:
  -i, --input PATH   Path to input profiles or directories containing
                     profiles. Can accept multiple paths.  [required]
  -o, --output FILE  Path to output profile.  [required]
  -h, --help         Show this message and exit.
```


## woltka_coverage

### Tool Description
Calculate per-sample coverage of feature groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/qiyunzhu/woltka
- **Package**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: woltka coverage [OPTIONS]

  Calculate per-sample coverage of feature groups.

Options:
  -i, --input FILE               Path to input profile.  [required]
  -m, --map FILE                 Mapping of feature groups to member features.
                                 [required]
  -o, --output FILE              Path to output coverage table.  [required]
  -t, --threshold INTEGER RANGE  Convert coverage to presence (1) / absence
                                 (0) data by this percentage threshold.
                                 [1<=x<=100]
  -c, --count                    Record numbers of covered features instead of
                                 percentages (overrides threshold).
  -n, --names PATH               Names of feature groups to append to the
                                 coverage table.
  -h, --help                     Show this message and exit.
```


## Metadata
- **Skill**: generated
