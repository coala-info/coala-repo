cwlVersion: v1.2
class: CommandLineTool
baseCommand: abricate
label: abricate
doc: "Find and collate amplicons in assembled contigs\n\nTool homepage: https://github.com/tseemann/abricate"
inputs:
  - id: contigs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input contig files (fasta, gbk, embl, optionally gzipped)
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependencies are installed.
    inputBinding:
      position: 102
      prefix: --check
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output CSV instead of TSV.
    inputBinding:
      position: 102
      prefix: --csv
  - id: datadir
    type:
      - 'null'
      - Directory
    doc: Databases folder
    inputBinding:
      position: 102
      prefix: --datadir
  - id: db
    type:
      - 'null'
      - string
    doc: Database to use
    inputBinding:
      position: 102
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose debug output.
    inputBinding:
      position: 102
      prefix: --debug
  - id: fofn
    type:
      - 'null'
      - File
    doc: Run on files listed in this file
    inputBinding:
      position: 102
      prefix: --fofn
  - id: identity
    type:
      - 'null'
      - boolean
    doc: Use %IDENTITY instead of %COVERAGE in summary table.
    inputBinding:
      position: 102
      prefix: --identity
  - id: list
    type:
      - 'null'
      - boolean
    doc: List included databases.
    inputBinding:
      position: 102
      prefix: --list
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum DNA %coverage
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minid
    type:
      - 'null'
      - float
    doc: Minimum DNA %identity
    inputBinding:
      position: 102
      prefix: --minid
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: Suppress column header row.
    inputBinding:
      position: 102
      prefix: --noheader
  - id: nopath
    type:
      - 'null'
      - boolean
    doc: Strip filename paths from FILE column.
    inputBinding:
      position: 102
      prefix: --nopath
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode, no stderr output.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: setupdb
    type:
      - 'null'
      - boolean
    doc: Format all the BLAST databases.
    inputBinding:
      position: 102
      prefix: --setupdb
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Summarize multiple reports into a table.
    inputBinding:
      position: 102
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: Use this many BLAST+ threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abricate:1.2.0--h05cac1d_0
stdout: abricate.out
