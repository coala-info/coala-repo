# woltka CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| woltka_classify | PASS |  |
| woltka_collapse | PASS |  |
| woltka_coverage | PASS |  |
| woltka_filter | PASS |  |
| woltka_merge | PASS |  |
| woltka_normalize | PASS |  |

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


## woltka_classify

### Tool Description
Main classification workflow: Alignments => profile(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/qiyunzhu/woltka
- **Package**: https://anaconda.org/channels/bioconda/packages/woltka/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: woltka classify [OPTIONS]

  Main classification workflow: Alignments => profile(s).

Options:
  -i, --input PATH                Path to input alignment file or directory of
                                  alignment files. Enter "-" for stdin.
                                  [required]
  -o, --output PATH               Path to output profile file or directory of
                                  profile files.  [required]
  -f, --format [sam|b6o|paf|map]  Format of read alignments: "sam": SAM
                                  format, "b6o": BLAST tabular format, "paf":
                                  PAF format, "map": simple query-to-subject
                                  map. If not specified, program will
                                  automatically infer from file content.
  -e, --filext TEXT               Input filename extension following sample
                                  ID.
  -s, --samples TEXT              Sample IDs to include in the analysis. Can
                                  be a comma-separated string or path to a
                                  list file. Also defines the order of samples
                                  in the output.
  --demux / --no-demux            Demultiplex alignment by first underscore in
                                  query identifier.
  -x, --exclude TEXT              Subject IDs to exclude while parsing
                                  alignments. Can be a comma-separated string
                                  or path to a list file. If an alignment is
                                  hit, the entire query (and its paired mate,
                                  if any) will be dropped.
  --trim-sub TEXT                 Trim subject IDs at the last given
                                  delimiter. Default: "_", or enter a custom
                                  value.
  --nodes PATH                    Hierarchies defined by NCBI nodes.dmp or
                                  compatible formats.
  --newick PATH                   Hierarchies defined by a tree in Newick
                                  format.
  --lineage PATH                  Lineage strings. Can accept Greengenes-style
                                  rank prefix.
  --columns PATH                  Table of classification units per rank
                                  (column).
  -m, --map PATH                  Mapping of lower classification units to
                                  higher ones.
  --map-as-rank / --map-no-rank   Extract rank name from map filename.
  -n, --names PATH                Names of classification units as defined by
                                  NCBI names.dmp or a simple map.
  -r, --rank TEXT                 Classify sequences at this rank. Enter
                                  "none" to directly report subjects; enter
                                  "free" for free-rank classification. Can
                                  specify multiple comma-separated ranks.
  --uniq                          One sequence can only be assigned to one
                                  classification unit, or remain unassigned if
                                  there is ambiguity. Otherwise, all candidate
                                  units are reported and their counts are
                                  normalized.
  --major INTEGER RANGE           In given-rank classification, use majority
                                  rule at this percentage threshold to
                                  determine assignment when there are multiple
                                  candidates.  [51<=x<=99]
  --above                         In given-rank classification, allow
                                  assigning a sequence to a higher rank if it
                                  cannot be assigned to the current rank.
  --subok                         In free-rank classification, allow assigning
                                  a sequence to its direct subject, if
                                  applicable, before going up in hierarchy.
  -c, --coords PATH               Reference gene coordinates on genomes.
  --overlap INTEGER RANGE         Read/gene overlapping percentage threshold.
                                  [default: 80; 1<=x<=100]
  -t, --stratify PATH             Directory of read-to-feature maps for
                                  stratification.
  -z, --sizes PATH                Divide counts by subject sizes. Can provide
                                  a mapping file, or type "." to calculate
                                  from gene coordinates.
  --frac                          Divide counts by total count of each sample
                                  (i.e., fractions).
  --scale TEXT                    Scale counts by this factor. Accepts "k",
                                  "M" suffixes.
  --digits INTEGER RANGE          Round counts to this number of digits after
                                  the decimal point.  [0<=x<=10]
  --to-biom / --to-tsv            Output profile format (BIOM or TSV).
  --unassigned                    Report unassigned sequences.
  --name-as-id                    Replace feature IDs with names.
  --add-rank                      Append feature ranks to table.
  --add-lineage                   Append lineage strings to table.
  -u, --outmap PATH               Write read-to-feature maps to this
                                  directory.
  --zipmap [none|gz|bz2|xz]       Compress read-to-feature maps using this
                                  algorithm.
  --outcov PATH                   Write subject coverage maps to this
                                  directory.
  --cov-fmt [bed|gff|0e|1e|0i|1i]
                                  Format of subject coverage coordinates.
                                  Default is BED-like (0-based, exclusive
                                  end).
  --chunk INTEGER                 Number of queries to read and parse in each
                                  chunk of alignment.
  --cache INTEGER                 Number of recent results to cache for faster
                                  classification.
  --no-exe                        Disable calling external programs for
                                  decompression.
  -h, --help                      Show this message and exit.
```

## Metadata
- **Skill**: generated
