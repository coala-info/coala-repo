cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_rarify
label: ccphylo_rarify
doc: "rarifies an KMA matrix.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: fragment_amount
    type:
      - 'null'
      - int
    doc: Total number of fragments in sample
    inputBinding:
      position: 101
      prefix: --fragment_amount
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input
  - id: rarification_factor
    type:
      - 'null'
      - int
    doc: Rarification factor
    inputBinding:
      position: 101
      prefix: --rarification_factor
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
