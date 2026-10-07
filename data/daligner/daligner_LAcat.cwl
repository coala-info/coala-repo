cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LAcat
label: daligner_LAcat
doc: "Concatenate .las alignment files into one .las file written to standard
  output.\n\nTool homepage: https://github.com/thegenemyers/DALIGNER"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 1
      prefix: -v
  - id: sources
    type:
      type: array
      items: File
    doc: The .las files to concatenate, in order
    inputBinding:
      position: 2
  - id: target
    type:
      - 'null'
      - string
    doc: Name of the concatenated .las file
    default: concatenated.las
outputs:
  - id: concatenated_alignments
    type: stdout
    doc: Concatenated alignment file
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: $(inputs.target)
