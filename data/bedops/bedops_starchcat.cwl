cwlVersion: v1.2
class: CommandLineTool
baseCommand: starchcat
label: bedops_starchcat
doc: "Concatenate multiple starch files into a single starch file. Note: The provided
  input text appears to be a system error log rather than help text; arguments are
  derived from standard tool documentation.\n\nTool homepage: http://bedops.readthedocs.io"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: One or more starch files to concatenate
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: Include a header in the output
    inputBinding:
      position: 102
      prefix: --header
  - id: note
    type:
      - 'null'
      - string
    doc: Append a note to the output archive metadata
    inputBinding:
      position: 102
      prefix: --note
  - id: remap
    type:
      - 'null'
      - boolean
    doc: Re-compress the data (useful if input files use different compression parameters)
    inputBinding:
      position: 102
      prefix: --remap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_starchcat.out
