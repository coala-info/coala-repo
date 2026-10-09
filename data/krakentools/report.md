# krakentools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| krakentools_alpha_diversity.py | PASS |  |
| krakentools_beta_diversity.py | PASS |  |
| krakentools_combine_kreports.py | PASS |  |
| krakentools_combine_mpa.py | PASS |  |
| krakentools_extract_kraken_reads.py | PASS |  |
| krakentools_filter_bracken.out.py | PASS |  |
| krakentools_fix_unmapped.py | PASS |  |
| krakentools_kreport2krona.py | PASS |  |
| krakentools_kreport2mpa.py | PASS |  |
| krakentools_make_kreport.py | PASS |  |
| krakentools_make_ktaxonomy.py | PASS |  |

## Metadata
- **Skill**: generated

## krakentools_extract_kraken_reads.py

### Tool Description
Extract reads from Kraken2 output based on taxonomic IDs. Supports both single-end and paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS
### Original Help Text
```text
usage: extract_kraken_reads.py [-h] -k KRAKEN_FILE -s SEQ_FILE1
                               [-s2 SEQ_FILE2] -t TAXID [TAXID ...]
                               -o OUTPUT_FILE [-o2 OUTPUT_FILE2] [--append]
                               [--noappend] [--max MAX_READS] [-r REPORT_FILE]
                               [--include-parents] [--include-children]
                               [--exclude] [--fastq-output]

options:
  -h, --help            show this help message and exit
  -k KRAKEN_FILE        Kraken output file to parse
  -s, -s1, -1, -U SEQ_FILE1
                        FASTA/FASTQ File containing the raw sequence letters.
  -s2, -2 SEQ_FILE2     2nd FASTA/FASTQ File containing the raw sequence
                        letters (paired).
  -t, --taxid TAXID [TAXID ...]
                        Taxonomy ID[s] of reads to extract (space-delimited)
  -o, --output OUTPUT_FILE
                        Output FASTA/Q file containing the reads and sample
                        IDs
  -o2, --output2 OUTPUT_FILE2
                        Output FASTA/Q file containig the second pair of reads
                        [required for paired input]
  --append              Append the sequences to the end of the output FASTA
                        file specified.
  --noappend            Create a new FASTA file containing sample sequences
                        and IDs (rewrite if existing) [default].
  --max MAX_READS       Maximum number of reads to save [default: 100,000,000]
  -r, --report REPORT_FILE
                        Kraken report file. [required only if --include-
                        parents/children is specified]
  --include-parents     Include reads classified at parent levels of the
                        specified taxids
  --include-children    Include reads classified more specifically than the
                        specified taxids
  --exclude             Instead of finding reads matching specified taxids,
                        finds all reads NOT matching specified taxids
  --fastq-output        Print output FASTQ reads [requires input FASTQ,
                        default: output is FASTA]
```

## krakentools_combine_kreports.py

### Tool Description
Combine multiple Kraken reports into one report.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: combine_kreports.py [-h] -r R_FILES [R_FILES ...] -o OUTPUT
                           [--display-headers] [--no-headers]
                           [--sample-names S_NAMES [S_NAMES ...]]
                           [--only-combined]

options:
  -h, --help            show this help message and exit
  -r, --report-file, --report-files, --report, --reports R_FILES [R_FILES ...]
                        Input kraken report files to combine (separate by
                        spaces)
  -o, --output OUTPUT   Output kraken report file with combined information
  --display-headers     Include header lines
  --no-headers          Do not include header lines
  --sample-names S_NAMES [S_NAMES ...]
                        Sample names to use as headers in the new report
  --only-combined       Include only the total combined reads column, not the
                        individual sample cols
```

## krakentools_filter_bracken.out.py

### Tool Description
Filter a Bracken output file by taxonomy IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_bracken.out.py [-h] -i IN_FILE -o OUT_FILE
                             [--include [T_INCLUDE ...]]
                             [--exclude [T_EXCLUDE ...]]

options:
  -h, --help            show this help message and exit
  -i, --input-file IN_FILE
                        Input bracken OUTPUT file. [NOT the report file]
  -o, --output, --output-file OUT_FILE
                        Output bracken OUTPUT file.
  --include [T_INCLUDE ...]
                        List of taxonomy IDs to include in output [space-
                        delimited] - default=All
  --exclude [T_EXCLUDE ...]
                        List of taxonomy IDs to exclude in output [space-
                        delimited] - default=None
```

## krakentools_fix_unmapped.py

### Tool Description
Map accession IDs to taxonomy IDs using accession2taxid files.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fix_unmapped.py [-h] -i IN_FILE
                       --accession2taxid REF_FILES [REF_FILES ...] -o OUT_FILE
                       [-r REM_FILE]

options:
  -h, --help            show this help message and exit
  -i, --input, --input_file IN_FILE
                        Input file containing accession IDs to map. Multi-
                        column files accepted. Only accessions in the first
                        column will be mapped.
  --accession2taxid REF_FILES [REF_FILES ...]
                        Accession2taxid reference mappings to search. NCBI
                        accession2taxid format required: 4 columns with
                        accessions in column 1 and taxonomy IDs in column 3.
  -o, --output, --output_file OUT_FILE
                        Output file with 2 tab-delimited columns for
                        accessions and taxids
  -r, --remaining REM_FILE
                        Name of text file containing non-found accessions from
                        input file
```

## krakentools_kreport2krona.py

### Tool Description
Convert a Kraken report to Krona text format.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kreport2krona.py [-h] -r R_FILE -o O_FILE [--intermediate-ranks]
                        [--no-intermediate-ranks]

options:
  -h, --help            show this help message and exit
  -r, --report-file, --report R_FILE
                        Input kraken report file for converting
  -o, --output O_FILE   Output krona-report file name
  --intermediate-ranks  Include non-traditional taxonomic ranks in output
  --no-intermediate-ranks
                        Do not include non-traditional taxonomic ranks in
                        output [default: no intermediate ranks]
```

## krakentools_make_kreport.py

### Tool Description
Make a Kraken report from Kraken output and a taxonomy file.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: make_kreport.py [-h] -i KRAKEN_FILE -t TAX_FILE -o OUT_FILE
                       [--use-read-len]

options:
  -h, --help            show this help message and exit
  -i, --input, -k, --kraken KRAKEN_FILE
                        Kraken output file (5 tab-delimited columns, taxid in
                        3rd column)
  -t, --taxonomy TAX_FILE
                        Output taxonomy file from make_ktaxonomy.py
  -o, --output OUT_FILE
                        Output kraken report file
  --use-read-len        Make report file using sum of read lengths [default:
                        read counts]
```

## krakentools_make_ktaxonomy.py

### Tool Description
Make a taxonomy file from nodes.dmp, names.dmp and seqid2taxid.map.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: make_ktaxonomy.py [-h] --nodes NODES_FILE --names NAMES_FILE
                         --seqid2taxid S2T_FILE -o OUT_FILE

options:
  -h, --help            show this help message and exit
  --nodes NODES_FILE    nodes.dmp file from taxonomy
  --names NAMES_FILE    names.dmp file from taxonomy
  --seqid2taxid S2T_FILE
                        seqid2taxid.map file
  -o, --output OUT_FILE
                        output taxonomy file
```

## krakentools_kreport2mpa.py

### Tool Description
Convert a Kraken report to MetaPhlAn-style format.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kreport2mpa.py [-h] -r R_FILE -o O_FILE [--display-header]
                      [--read_count] [--percentages] [--intermediate-ranks]
                      [--no-intermediate-ranks] [--remove-spaces |
                      --keep-spaces]

options:
  -h, --help            show this help message and exit
  -r, --report-file, --report R_FILE
                        Input kraken report file for converting
  -o, --output O_FILE   Output mpa-report file name
  --display-header      Include header [Kraken report filename] in mpa-report
                        file [default: no header]
  --read_count          Use read count for output [default]
  --percentages         Use percentages for output [instead of reads]
  --intermediate-ranks  Include non-traditional taxonomic ranks in output
  --no-intermediate-ranks
                        Do not include non-traditional taxonomic ranks in
                        output [default]
  --remove-spaces       Replace space with underscore in taxon name [default]
  --keep-spaces         Do not replace space with underscore in taxon name
```

## krakentools_combine_mpa.py

### Tool Description
Combine mpa-style reports into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: combine_mpa.py [-h] -i IN_FILES [IN_FILES ...] -o O_FILE

options:
  -h, --help            show this help message and exit
  -i, --input IN_FILES [IN_FILES ...]
                        Input files for this program (files generated by
                        kreport2mpa.py)
  -o, --output O_FILE   Single mpa-report file name
```

## krakentools_alpha_diversity.py

### Tool Description
Calculate alpha diversity from a Bracken file.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alpha_diversity.py [-h] [-f FILENAME] [-a VALUE]

Pick an alpha diversity.

options:
  -h, --help            show this help message and exit
  -f, --filename FILENAME
                        bracken file with species abundance estimates
  -a, --alpha VALUE     type of alpha diversity to calculate Sh, BP, Si, ISi,
                        F, default = Sh
```

## krakentools_beta_diversity.py

### Tool Description
Calculate Bray-Curtis dissimilarity between communities.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/jenniferlu717/KrakenTools
- **Package**: https://anaconda.org/channels/bioconda/packages/krakentools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: beta_diversity.py [-h] -i IN_FILES [IN_FILES ...]
                         [--type {single,simple,bracken,kreport,kreport2,krona}]
                         [--cols COLS] [--level {all,S,G,F,O}]

options:
  -h, --help            show this help message and exit
  -i, --input, --input-files, --inputs IN_FILES [IN_FILES ...]
                        Input files (one per community) for which to compare
                        for bray-curtis dissimiliarity metrics
  --type {single,simple,bracken,kreport,kreport2,krona}
                        Type of input file[s]: single, simple [tab-delimited,
                        specify --cols], bracken, kreport, kreport2, krona.
                        See docs for details
  --cols, --columns COLS
                        Specify category/counts separated by single comma:
                        cat,counts (1 = first col)
  --level, -l {all,S,G,F,O}
                        For Kraken or Krona files, taxonomy level for which to
                        compare samples. Default: all
```
