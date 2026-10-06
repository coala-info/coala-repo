# biopet-seattleseqkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biopet-seattleseqkit_filter | PASS |  |
| biopet-seattleseqkit_mergegenes | PASS |  |
| biopet-seattleseqkit_multifilter | PASS |  |

## biopet-seattleseqkit_filter

### Tool Description
Filters a SeattleSeq file by bed regions and field values.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
- **Homepage**: https://github.com/biopet/seattleseqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-seattleseqkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-seattleseqkit/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/seattleseqkit
- **Stars**: N/A
### Original Help Text
```text
General Biopet options


Options for Filter

Usage: Filter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <value>  Seattle seq input file
  -o, --outputFile <value>
                           Seattle seq output file
  --geneColapseOutput <value>
                           Output file to count per gene hits
  --intervals <value>      Intervals bed file
  --fieldMustContain:<key>=<key>=<text>
                           Field must contain given text
  --fieldMustBeBelow:<key>=<key>=<double>
                           Field must be below given numeric value
  --fieldMustBeAbove:<key>=<key>=<double>
                           Field must be below given numeric value
```


## biopet-seattleseqkit_mergegenes

### Tool Description
Merges per-sample gene count files into one table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
- **Homepage**: https://github.com/biopet/seattleseqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-seattleseqkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-seattleseqkit/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/seattleseqkit
- **Stars**: N/A
### Original Help Text
```text
General Biopet options


Options for MergeGenes

Usage: MergeGenes [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile:<key>=<value>
                           Gene counts per sample
  -o, --outputFile <value>
                           Output merges genes counts
```


## biopet-seattleseqkit_multifilter

### Tool Description
Filters SeattleSeq files of several samples and merges their gene counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-seattleseqkit:0.2--0
- **Homepage**: https://github.com/biopet/seattleseqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-seattleseqkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-seattleseqkit/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/seattleseqkit
- **Stars**: N/A
### Original Help Text
```text
General Biopet options


Options for MultiFilter

Usage: MultiFilter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile:<key>=<value>
                           Seattle seq input file
  -o, --outputDir <value>  Output directory
  --multiSampleTreshold <value>
                           Minimal number of samples per gene, default: 2
  --geneColapseOutput <value>
                           Output file to count per gene hits
  --intervals:<key>=<value>
                           Intervals bed file
  --fieldMustContain:<key>=<key>=<text>
                           Field must contain given text
  --fieldMustBeBelow:<key>=<key>=<double>
                           Field must be below given numeric value
  --fieldMustBeAbove:<key>=<key>=<double>
                           Field must be below given numeric value
```


## Metadata
- **Skill**: generated

