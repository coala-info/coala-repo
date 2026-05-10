cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_count
label: taxmapper_count
doc: "Count taxa based on a filtered taxonomy mapping file.\n\nTool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: taxa_file
    type: File
    doc: Filtered taxonomy mapping file.
    inputBinding:
      position: 101
      prefix: --tax
  - id: output1_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output1_path`
    inputBinding:
      position: 102
      prefix: --output1
  - id: output2_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output2_path`
    inputBinding:
      position: 103
      prefix: --output2
outputs:
  - id: output1
    type:
      - 'null'
      - File
    doc: Output file 1, counted taxa for first taxonomic hierarchy
    outputBinding:
      glob: $(inputs.output1_path)
  - id: output2
    type:
      - 'null'
      - File
    doc: Output file 2, counted taxa for second taxonomic hierarchy
    outputBinding:
      glob: $(inputs.output2_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
