cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta-utils
  - uid
label: mgkit_fasta-utils_uid
doc: "Changes each header of a FASTA file to a uid (unique ID)\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: table
    type:
      - 'null'
      - string
    doc: Filename of a table to record the changes (by default discards it)
    inputBinding:
      position: 101
      prefix: -t
  - id: fasta_file
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 102
  - id: output_file
    type: string
    doc: Output file name (written instead of standard output).
    inputBinding:
      position: 103
outputs:
  - id: output
    type: File
    doc: FASTA file with unique ids as headers.
    outputBinding:
      glob: $(inputs.output_file)
  - id: table_out
    type:
      - 'null'
      - File
    doc: Table of header changes.
    outputBinding:
      glob: $(inputs.table)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
