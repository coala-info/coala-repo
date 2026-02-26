cwlVersion: v1.2
class: CommandLineTool
baseCommand: commec flag
label: commec_flag
doc: "Parse all .screen, or .json files in a directory and create CSVs of flags raised\n\
  \nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs:
  - id: directory
    type: Directory
    doc: Directory containing .screen files to summarize
    inputBinding:
      position: 1
  - id: evalportal_format
    type:
      - 'null'
      - boolean
    doc: Output format compatible with the IBBIS sceening evaluation portal
    inputBinding:
      position: 102
      prefix: --evalportal-format
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search directory recursively for screen files
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory name (defaults to directory if not provided)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
