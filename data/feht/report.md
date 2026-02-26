# feht CWL Generation Report

## feht

### Tool Description
Predictive marker discovery for groups; binary data, genomic data (single nucleotide variants), and arbitrary character data.

### Metadata
- **Docker Image**: quay.io/biocontainers/feht:1.1.0--0
- **Homepage**: https://github.com/chadlaing/feht/
- **Package**: https://anaconda.org/channels/bioconda/packages/feht/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/feht/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chadlaing/feht
- **Stars**: N/A
### Original Help Text
```text
feht - predictive marker discovery

Usage: feht (-i|--infoFile FILE) (-d|--datafile FILE)
            [--one "Group1Name Group1Item Group1Item Group1Item"]
            [--two "Group2Name Group2Item Group2Item Group2Item"]
            [-l|--delimiter [',', '\t' ...], DEFAULT='\t']
            [-m|--mode ['binary', 'snp'], DEFAULT='binary']
            [-c|--correction ['none', 'bonferroni'], DEFAULT='bonferroni']
            [-f|--ratioFilter [Filter results by ratio (0.00-1.00), DEFAULT=0]]
  Predictive marker discovery for groups; binary data, genomic data (single
  nucleotide variants), and arbitrary character data.

Available options:
  -i,--infoFile FILE       File of metadata information
  -d,--datafile FILE       File of binary or single-nucleotide variant data
  --one "Group1Name Group1Item Group1Item Group1Item"
                           Group1 column name, followed by optional Group1
                           labels to include as part of the group
  --two "Group2Name Group2Item Group2Item Group2Item"
                           Group2 column name, followed by optional Group2
                           labels to include as part of the group
  -l,--delimiter [',', '\t' ...], DEFAULT='\t'
                           Delimiter used for both the metadata and data file
  -m,--mode ['binary', 'snp'], DEFAULT='binary'
                           Mode for program data; either 'binary' or 'snp'
  -c,--correction ['none', 'bonferroni'], DEFAULT='bonferroni'
                           Multiple-testing correction to apply
  -f,--ratioFilter [Filter results by ratio (0.00-1.00), DEFAULT=0]
                           Display only those results greater than or equal to
                           the value
  -h,--help                Show this help text
```

