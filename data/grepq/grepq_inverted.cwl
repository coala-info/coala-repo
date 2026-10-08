cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grepq
label: grepq_inverted
doc: "Print records where none of the regex patterns are found.\n\nTool homepage: https://github.com/Rbfinch/grepq"
arguments:
  - position: 4
    valueFrom: inverted
inputs:
  - id: output_name
    type: string
    default: grepq_inverted.txt
    doc: "Name of the file that receives the standard output."
  - id: include_id
    type:
      - 'null'
      - boolean
    doc: "Include record ID in the output"
    inputBinding:
      position: 1
      prefix: --includeID
  - id: include_record
    type:
      - 'null'
      - boolean
    doc: "Include record ID, sequence, separator, and quality field in the output (i.e. FASTQ format)"
    inputBinding:
      position: 1
      prefix: --includeRecord
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Output in FASTA format"
    inputBinding:
      position: 1
      prefix: --fasta
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Count the number of matching FASTQ records"
    inputBinding:
      position: 1
      prefix: --count
  - id: read_gzip
    type:
      - 'null'
      - boolean
    doc: "Read the FASTQ file in gzip compressed format"
    inputBinding:
      position: 1
      prefix: --read-gzip
  - id: write_gzip
    type:
      - 'null'
      - boolean
    doc: "Write the output in gzip compressed format"
    inputBinding:
      position: 1
      prefix: --write-gzip
  - id: read_zstd
    type:
      - 'null'
      - boolean
    doc: "Read the FASTQ file in zstd compressed format"
    inputBinding:
      position: 1
      prefix: --read-zstd
  - id: write_zstd
    type:
      - 'null'
      - boolean
    doc: "Write the output in zstd compressed format"
    inputBinding:
      position: 1
      prefix: --write-zstd
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "Use fast compression"
    inputBinding:
      position: 1
      prefix: --fast
  - id: best
    type:
      - 'null'
      - boolean
    doc: "Use best compression"
    inputBinding:
      position: 1
      prefix: --best
  - id: patterns
    type: File
    doc: "Patterns file in plain text (one regex per line) or JSON format."
    inputBinding:
      position: 2
  - id: fastq
    type: File
    doc: "FASTQ file in plain text, gzip or zstd compressed format."
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: "Records without a match (format set by the options)."
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
