cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - predex
  - ipa
label: predex_ipa
doc: "Input dir with IPA downloaded table\n\nTool homepage: https://github.com/tomkuipers1402/predex"
inputs:
  - id: extension
    type:
      - 'null'
      - string
    doc: Extension of IPA files
    inputBinding:
      position: 101
      prefix: --extension
  - id: input
    type: Directory
    doc: Input dir with IPA downloaded table
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output dir to write processed data to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
