cwlVersion: v1.2
class: CommandLineTool
baseCommand: ONEview
label: fastga_ONEview
doc: "Shows a 1-code file (for example a .1aln alignment file) as readable text.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: onefile
    type: File
    doc: The 1-code file to show.
    inputBinding:
      position: 100
  - id: file_type
    type:
      - 'null'
      - string
    doc: 'File type, for example seq or aln; required if the file has no header.'
    inputBinding:
      position: 101
      prefix: '-t'
  - id: schema
    type:
      - 'null'
      - File
    doc: Schema file for reading the file.
    inputBinding:
      position: 101
      prefix: '-S'
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Skip the header in ascii output.
    inputBinding:
      position: 101
      prefix: '-h'
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Only write the header (in ascii).
    inputBinding:
      position: 101
      prefix: '-H'
  - id: write_schema
    type:
      - 'null'
      - boolean
    doc: Write a schema file based on this file.
    inputBinding:
      position: 101
      prefix: '-s'
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Write in binary (default is ascii).
    inputBinding:
      position: 101
      prefix: '-b'
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output file name. [default: standard output]'
    inputBinding:
      position: 101
      prefix: '-o'
  - id: index
    type:
      - 'null'
      - string[]
    doc: 'Write specified objects or groups of type T: <T> <x>[-<y>][,<x>[-<y>]]* (binary files only), for example A 0-10.'
    inputBinding:
      position: 101
      prefix: '-i'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Write commentary including timing.
    inputBinding:
      position: 101
      prefix: '-v'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: File written when output is set.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ONEview.out
