cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlst
label: mlst
doc: "Scan contig files against PubMLST schemes for multi-locus sequence typing\n\n
  Tool homepage: https://github.com/tseemann/mlst"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/GBK/Files to scan
    inputBinding:
      position: 1
  - id: blastdb
    type:
      - 'null'
      - File
    doc: Use a custom BLAST database
    inputBinding:
      position: 102
      prefix: --blastdb
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependencies and exit
    inputBinding:
      position: 102
      prefix: --check
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output in CSV format
    inputBinding:
      position: 102
      prefix: --csv
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output in JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Use legacy output format
    inputBinding:
      position: 102
      prefix: --legacy
  - id: list
    type:
      - 'null'
      - boolean
    doc: List available schemes
    inputBinding:
      position: 102
      prefix: --list
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum DNA coverage
    default: 10
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minid
    type:
      - 'null'
      - float
    doc: Minimum DNA identity
    default: 95
    inputBinding:
      position: 102
      prefix: --minid
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: scheme
    type:
      - 'null'
      - string
    doc: Force a specific scheme
    inputBinding:
      position: 102
      prefix: --scheme
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlst:2.32.2--hdfd78af_0
stdout: mlst.out
