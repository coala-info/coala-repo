# architeuthis CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| architeuthis_lineage | PASS |  |
| architeuthis_mapping_filter | PASS |  |
| architeuthis_mapping_kmers | PASS |  |
| architeuthis_mapping_score | PASS |  |
| architeuthis_mapping_summary | PASS |  |
| architeuthis_merge | PASS |  |

## architeuthis_lineage

### Tool Description
Add lineage information to Bracken output.

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis lineage [flags]

Flags:
      --data-dir string   The path to the taxonomy dumps.
  -f, --format string     The taxonomic ranks to consider during scoring. (default "d__{domain|acellularroot|superkingdom};p__{phylum};c__{class};o__{order};f__{family};g__{genus};s__{species}")
  -h, --help              help for lineage
  -o, --out string        The filename of the output CSV. (default "annotated.csv")

Global Flags:
      --db string   path to the Kraken database [optional]
```

## architeuthis_merge

### Tool Description
Merge results using architeuthis

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis merge [flags]

Flags:
  -h, --help         help for merge
  -o, --out string   The output filename. (default "merged.csv")

Global Flags:
      --db string   path to the Kraken database [optional]
```


## architeuthis_mapping_filter

### Tool Description
Filter Kraken output based on read quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis mapping filter [flags]

Flags:
      --data-dir string           The path to the taxonomy dumps.
  -f, --format string             The taxonomic ranks to connsider during scoring. (default "d__{domain|acellularroot|superkingdom};p__{phylum};c__{class};o__{order};f__{family};g__{genus};s__{species}")
  -h, --help                      help for filter
      --max-entropy float         Maximum entropy for kmer classifications at classified rank. (default 0.1)
      --max-multiplicity uint32   Maximum number of alternative classifications on the classified rank. (default 2)
      --min-consistency float     Minimum consistency of the read classification. (default 0.9)
      --out string                The output file (Kraken format). (default "filtered.k2")

Global Flags:
      --db string   path to the Kraken database [optional]
```

## architeuthis_mapping_kmers

### Tool Description
Summarize k-mer assignments for classified taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis mapping kmers [flags]

Flags:
  -h, --help         help for kmers
      --out string   The output file (CSV format). (default "mapping_kmers.csv")

Global Flags:
      --db string   path to the Kraken database [optional]
```

## architeuthis_mapping_score

### Tool Description
Scores and evaluates reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis mapping score [flags]

Flags:
      --data-dir string   The path to the taxonomy dumps.
  -f, --format string     The taxonomic ranks to connsider during scoring. (default "d__{domain|acellularroot|superkingdom};p__{phylum};c__{class};o__{order};f__{family};g__{genus};s__{species}")
  -h, --help              help for score
      --out string        The output file (CSV format). (default "mapping_scores.csv")

Global Flags:
      --db string   path to the Kraken database [optional]
```

## architeuthis_mapping_summary

### Tool Description
Summarize k-mer assignments for classified taxa on taxonomic ranks.

### Metadata
- **Docker Image**: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
- **Homepage**: https://github.com/cdiener/architeuthis
- **Package**: https://anaconda.org/channels/bioconda/packages/architeuthis/overview
- **Validation**: PASS

### Original Help Text
```text
Error: unknown shorthand flag: 'e' in -elp
Usage:
  architeuthis mapping summary [flags]

Flags:
      --data-dir string   The path to the taxonomy dumps.
  -f, --format string     The taxonomic ranks to connsider during scoring. (default "d__{domain|acellularroot|superkingdom};p__{phylum};c__{class};o__{order};f__{family};g__{genus};s__{species}")
  -h, --help              help for summary
      --out string        The output file (CSV format). (default "mapping_summary.csv")

Global Flags:
      --db string   path to the Kraken database [optional]
```

## Metadata
- **Skill**: generated
