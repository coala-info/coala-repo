cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - md5sum
label: smof_md5sum
doc: "Calculate an md5 checksum for the input sequences.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: "Convert all to uppercase, before hashing"
    inputBinding:
      position: 100
      prefix: --ignore-case
  - id: each_sequence
    type:
      - 'null'
      - boolean
    doc: "Calculate md5sum for each sequence (TAB delimited)"
    inputBinding:
      position: 101
      prefix: --each-sequence
  - id: all_sequences
    type:
      - 'null'
      - boolean
    doc: "Calculate one md5sum for all concatenated sequences"
    inputBinding:
      position: 102
      prefix: --all-sequences
  - id: all_headers
    type:
      - 'null'
      - boolean
    doc: "Calculate one md5sum for all concatenated headers"
    inputBinding:
      position: 103
      prefix: --all-headers
  - id: replace_header
    type:
      - 'null'
      - boolean
    doc: "Replace the header of each entry with the checksum of the sequence"
    inputBinding:
      position: 104
      prefix: --replace-header
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_md5sum.out
