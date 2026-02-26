cwlVersion: v1.2
class: CommandLineTool
baseCommand: fa-lint
label: fa-lint
doc: "FASTA file linter and validator\n\nTool homepage: https://github.com/GallVp/fa-lint"
inputs:
  - id: allow_stop_anywhere
    type:
      - 'null'
      - boolean
    doc: Allow stop-codons anywhere in the sequence. Use in combination with -s 
      or -S
    inputBinding:
      position: 101
      prefix: -a
  - id: allow_stop_asterisk
    type:
      - 'null'
      - boolean
    doc: Allow stop-codon denoted by '*' as the last character in a sequence
    inputBinding:
      position: 101
      prefix: -S
  - id: allow_stop_dot
    type:
      - 'null'
      - boolean
    doc: Allow stop-codon denoted by '.' as the last character in a sequence
    inputBinding:
      position: 101
      prefix: -s
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta[.gz] file to process
    inputBinding:
      position: 101
      prefix: -fasta
  - id: strict_id_validation
    type:
      - 'null'
      - boolean
    doc: Enable strict alphanumeric FASTA ID validation (A-Za-z0-9_ only)
    inputBinding:
      position: 101
      prefix: -w
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 6
    inputBinding:
      position: 101
      prefix: -threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fa-lint:1.2.0--he881be0_0
stdout: fa-lint.out
