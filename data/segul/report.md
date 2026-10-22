# segul CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| segul_align_concat | PASS | concatenated 5 tutorial UCE alignments: 4 taxa x 6341 sites (sum of 1286+1286+1147+1322+1300) plus a raxml partition file with the 5 loci |
| segul_align_convert | PASS | converted 5 real UCE locus alignments (SECAPR tutorial, 4 taxa) from fasta to nexus; ntax=4 nchar=1286 for locus_0 |
| segul_align_filter | PASS | --min-len 1250 kept 4 of 5 tutorial alignments (the 1147 bp locus was dropped); segul adds the setting to the output folder name |
| segul_align_summary | PASS | per-locus summary of 5 tutorial alignments: csv with per-taxon missing data and base counts (total_chars 1286, 227 missing for T_pella5) |
| segul_align_trim | PASS | --missing-data 0.5 trimmed tutorial alignments (locus_1 1286 to 1133 sites); trimming_summary.csv matches the output lengths |
| segul_partition_convert | Failed | tool bug: --output is ignored (result is always written beside the input as <input>_partition.<ext>, failing on read-only input); raxml to nexus conversion content was correct once the input was staged writable |
| segul_read_summary | PASS | complete read summary of the nf-core sarscov2 test_1.fastq: 100 reads, 13897 bases, mean length 138.97, matching a direct count |
| segul_sequence_extract | PASS | extracted 2 taxa (T_pyra1;T_pella5) from 5 tutorial alignments |
| segul_sequence_rename | PASS | replaced T_ with Taxon_ in all sequence IDs of 5 tutorial alignments |
| segul_sequence_translate | PASS | translated 3 real sarscov2 CDS starts (300 nt, nf-core genome) to protein; orf1ab gives MESLVPGFNEKTHVQLSL... |

## segul_align_summary

### Tool Description
Compute alignment statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Compute Alignment Statistics

Usage: segul align summary [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -o, --output <OUTPUT>
          Output path [default: Align-Summary]
      --log <LOG>
          Log file path [default: segul.log]
      --prefix <PREFIX>
          Specify prefix for output files
      --interval <INTERVAL>
          Specify interval value for counting data matrix completeness [default: 5] [possible values: 1, 2, 5, 10]
      --per-locus
          Generate summary statistic for each locus
  -h, --help
          Print help
```

## segul_read_summary

### Tool Description
Compute sequence read statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Compute sequence read statistics

Usage: segul read summary [OPTIONS]

Options:
  -d, --dir <PATH>                   Input a directory
  -i, --input [<INPUT>...]           Input a path (allow wildcard)
      --force                        Force overwriting existing output files/directory
  -f, --input-format <INPUT_FORMAT>  Specify input format [default: auto] [possible values: auto, fastq, gzip]
      --mode <MODE>                  Summary mode [default: default] [possible values: minimal, default, complete]
  -o, --output <OUTPUT>              Output path [default: Read-Summary]
      --log <LOG>                    Log file path [default: segul.log]
      --prefix <PREFIX>              Specify prefix for output files
  -h, --help                         Print help
```

## segul_align_concat

### Tool Description
Concatenate alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Concatenate alignments

Usage: segul align concat [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -p, --partition-format <PART_FMT>
          Specify partition output format [default: nexus] [possible values: charset, nexus, raxml]
      --codon
          Set as a codon model partition format
      --prefix <PREFIX>
          Specify prefix for output files
  -o, --output <OUTPUT>
          Output path [default: Align-Concat]
      --sort
          Sort sequences by IDs alphabetically
  -h, --help
          Print help
```

## segul_sequence_rename

### Tool Description
Batch renaming sequence IDs across multiple alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Batch renaming sequence IDs across multiple alignments

Usage: segul sequence rename [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -o, --output <OUTPUT>
          Output path [default: Sequence-Rename]
      --dry-run
          Dry run
      --replace-id <REPLACE_ID>
          Rename using input IDs in a file
      --remove <REMOVE>
          Remove matching input string
      --remove-re=<REMOVE_RE>
          Remove first found matching input regular expression
      --replace-from=<REPLACE_FROM>
          Replace matching input string with the output string
      --remove-re-all=<REMOVE_RE_ALL>
          Remove all found matching input regular expression
      --replace-from-re=<REPLACE_FROM_RE>
          Replace first found matching input regular expression with the output string
      --replace-from-re-all=<REPLACE_FROM_RE_ALL>
          Replace all found matching input regular expression with the output string
      --replace-to=<REPLACE_TO>
          Replace matching input string with the output string
  -h, --help
          Print help
```

## segul_sequence_translate

### Tool Description
Translate DNA to amino acid sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Translate DNA to amino acid sequences

Usage: segul sequence translate [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -o, --output <OUTPUT>
          Output path [default: Sequence-Translate]
      --show-tables
          Show supported NCBI translation tables
      --reading-frame <READING_FRAME>
          Specify reading frame [default: 1] [possible values: 1, 2, 3]
      --auto-read
          Automatically detect reading frame
      --table <NUMBER>
          Specify NCBI translation table [default: 1] [possible values: 1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 16, 21, 22, 23, 24, 25, 26, 29, 30, 33]
  -h, --help
          Print help
```

## segul_partition_convert

### Tool Description
Convert partition formats

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Convert partition formats

Usage: segul partition convert [OPTIONS]

Options:
  -i, --input <INPUT>
          Input a path (allow wildcard)
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
  -o, --output <OUTPUT>
          Output path [default: Partition-Convert]
  -p, --input-partition <PART_FMT>
          Specify partition format [possible values: charset, nexus, raxml]
      --codon
          Set codon model partition format
      --log <LOG>
          Log file path [default: segul.log]
  -P, --output-partition <OUT_PART>
          Specify partition format [default: nexus] [possible values: charset, nexus, raxml]
      --force
          Force overwriting existing output files/directory
      --skip-checking
          Skip checking partition formats
  -h, --help
          Print help
```

## segul_sequence_extract

### Tool Description
Extract sequence from alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Extract sequence from alignments

Usage: segul sequence extract [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -o, --output <OUTPUT>
          Output path [default: Sequence-Extract]
      --re=<RE>
          Specify regular expression for extracting sequences
      --id=<ID>
          Input sequence IDa separated by semicolon
      --file <FILE>
          Specify file for extracting sequences
  -h, --help
          Print help
```

## segul_align_filter

### Tool Description
Filter alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Filter alignments

Usage: segul align filter [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -p, --partition-format <PART_FMT>
          Specify partition output format [default: nexus] [possible values: charset, nexus, raxml]
      --codon
          Set as a codon model partition format
      --prefix <PREFIX>
          Specify prefix for output files
  -o, --output <OUTPUT>
          Output path [default: Align-Filter]
      --concat
          Concat filtered alignments
      --min-len <MIN_LEN>
          Filter by minimum sequence length
      --max-len <MAX_LEN>
          Filter by maximum sequence length
      --missing-data <MISSING>
          Filter by proportion of missing data
      --npercent <NPERCENT>
          Filter by multiple minimal taxon percentage
      --min-ntax <MIN_NTAX>
          Filter by minimal taxon number
      --percent <PERCENT>
          Filter by minimal taxon percentage
      --percent-inf <PERCENT_INF>
          Filter by minimal parsimony informative percentage.
      --min-pinf <MIN_PINF>
          Filter by minimal parsimony informative sites
      --max-pinf <MAX_PINF>
          Filter by maximum parsimony informative sites
      --taxon-id <IDS>
          Filter by taxon ID
  -h, --help
          Print help
```

## segul_align_trim

### Tool Description
Trim alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Trim alignment

Usage: segul align trim [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -o, --output <OUTPUT>
          Output path [default: Align-Trim]
      --missing-data <MISSING DATA>
          Trim based on a threshold of missing data
      --pinf <PIS>
          Trim based on a threshold of Parsimony Informative sites (PIS)
  -h, --help
          Print help
```

## segul_align_convert

### Tool Description
Convert sequence formats

### Metadata
- **Docker Image**: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
- **Homepage**: https://github.com/hhandika/segul
- **Package**: https://anaconda.org/channels/bioconda/packages/segul/overview
- **Validation**: PASS

### Original Help Text
```text
Convert sequence formats

Usage: segul align convert [OPTIONS]

Options:
  -d, --dir <PATH>
          Input a directory
  -i, --input [<INPUT>...]
          Input a path (allow wildcard)
      --force
          Force overwriting existing output files/directory
  -f, --input-format <SEQUENCE INPUT FORMAT>
          Specify input format [default: auto] [possible values: auto, fasta, nexus, phylip]
      --datatype <DATATYPE>
          Specify sequence datatype [default: dna] [possible values: dna, aa, ignore]
  -F, --output-format <OUTPUT_FMT>
          Specify output format [default: nexus] [possible values: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int]
      --log <LOG>
          Log file path [default: segul.log]
  -o, --output <OUTPUT>
          Output path [default: Align-Convert]
      --sort
          Sort sequences by IDs alphabetically
  -h, --help
          Print help
```

## Metadata
- **Skill**: generated
