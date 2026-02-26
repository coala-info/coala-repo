cwlVersion: v1.2
class: CommandLineTool
baseCommand: smafa_query
label: smafa_query
doc: "This command searches a database for query sequences. The database must be generated
  with the `makedb` command. The query sequences can be in FASTA or FASTQ format.
  The output is a tab-separated file with the following columns:\n\n1. Query sequence
  number (0-indexed)\n2. Subject sequence number (0-indexed)\n3. Divergence (number
  of nucleotides different between the two sequences\n4. Subject sequence (with dashes
  and degenerate base symbols shown as Ns)\n\nTool homepage: https://github.com/wwood/smafa"
inputs:
  - id: database
    type: File
    doc: Output from makedb
    inputBinding:
      position: 101
      prefix: --database
  - id: limit_per_sequence
    type:
      - 'null'
      - int
    doc: Maximum number of hits to report per sequence. Requires --max-num-hits 
      > 1 for now.
    default: not used
    inputBinding:
      position: 101
      prefix: --limit-per-sequence
  - id: max_divergence
    type:
      - 'null'
      - int
    doc: Maximum divergence to report hits for, for each sequence
    default: not used
    inputBinding:
      position: 101
      prefix: --max-divergence
  - id: max_num_hits
    type:
      - 'null'
      - int
    doc: Maximum number of hits to report
    default: 1
    inputBinding:
      position: 101
      prefix: --max-num-hits
  - id: query
    type: File
    doc: Query sequences to search with in FASTX format
    inputBinding:
      position: 101
      prefix: --query
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Unless there is an error, do not print logging information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
stdout: smafa_query.out
