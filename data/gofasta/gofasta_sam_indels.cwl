cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - sam
  - indels
label: gofasta_sam_indels
doc: "Parse a SAM file for raw indel information

Tool homepage: https://github.com/virus-evolution/gofasta"
inputs:
  - id: reference
    type: File
    doc: "Reference fasta file used to generate the sam file"
    inputBinding:
      position: 101
      prefix: --reference
  - id: samfile
    type: File
    doc: "Samfile to read. If none is specified, will read from stdin"
    inputBinding:
      position: 101
      prefix: --samfile
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: insertions_out
    type:
      - 'null'
      - string
    doc: "Where to write the insertions (default insertions.txt)"
    inputBinding:
      position: 101
      prefix: --insertions-out
  - id: deletions_out
    type:
      - 'null'
      - string
    doc: "Where to write the deletions (default deletions.txt)"
    inputBinding:
      position: 101
      prefix: --deletions-out
  - id: threshold
    type:
      - 'null'
      - int
    doc: "Minimum count for an indel to be included in the output (default 2)"
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: insertions
    type:
      - 'null'
      - File
    doc: "Insertions file"
    outputBinding:
      glob: "$(inputs.insertions_out ? inputs.insertions_out : 'insertions.txt')"
  - id: deletions
    type:
      - 'null'
      - File
    doc: "Deletions file"
    outputBinding:
      glob: "$(inputs.deletions_out ? inputs.deletions_out : 'deletions.txt')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_sam_indels.out
