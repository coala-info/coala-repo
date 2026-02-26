cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_pepxml_to_table.rb
label: protk_pepxml_to_table.rb
doc: "Convert a pepXML file to a tab delimited table.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: input_file
    type: File
    doc: Input pepXML file
    inputBinding:
      position: 1
  - id: invert_probabilities
    type:
      - 'null'
      - boolean
    doc: Output 1-p instead of p for all probability values
    default: 'false'
    inputBinding:
      position: 102
      prefix: --invert-probabilities
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
