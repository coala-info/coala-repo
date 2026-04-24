cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgf-formatter
label: mgf-formatter
doc: "A tool for formatting MGF (Mascot Generic Format) files.\n\nTool homepage: https://github.com/rformassspectrometry/MsBackendMgf"
inputs:
  - id: input
    type: File
    doc: Input file to be formatted
    inputBinding:
      position: 1
  - id: itraq_filter
    type:
      - 'null'
      - boolean
    doc: Apply iTRAQ filter
    inputBinding:
      position: 102
      prefix: --itraq_filter
  - id: mgf_format
    type:
      - 'null'
      - string
    doc: Specify the MGF format style
    inputBinding:
      position: 102
      prefix: --mgf_format
  - id: no_split_multiple_charge_states
    type:
      - 'null'
      - boolean
    doc: Do not split multiple charge states
    inputBinding:
      position: 102
      prefix: --no_split_multiple_charge_states
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgf-formatter:1.0.0--py27_1
