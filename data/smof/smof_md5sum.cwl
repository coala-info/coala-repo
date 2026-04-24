cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof md5sum
label: smof_md5sum
doc: "Concatenates all headers and sequences and calculates the md5sum for the resulting
  string.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
  - id: all_headers
    type:
      - 'null'
      - boolean
    doc: calculate one md5sum for all concatenated headers
    inputBinding:
      position: 102
      prefix: --all-headers
  - id: all_sequences
    type:
      - 'null'
      - boolean
    doc: calculate one md5sum for all concatenated sequences
    inputBinding:
      position: 102
      prefix: --all-sequences
  - id: each_sequence
    type:
      - 'null'
      - boolean
    doc: calculate md5sum for each sequence (TAB delimited)
    inputBinding:
      position: 102
      prefix: --each-sequence
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: convert all to uppercase, before hashing
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: replace_header
    type:
      - 'null'
      - boolean
    doc: replace the header of each entry with the checksum of the sequence
    inputBinding:
      position: 102
      prefix: --replace-header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_md5sum.out
