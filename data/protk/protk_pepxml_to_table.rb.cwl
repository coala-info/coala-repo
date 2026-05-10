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
    inputBinding:
      position: 102
      prefix: --invert-probabilities
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
