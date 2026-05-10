cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_mean
label: wiggletools_mean
doc: "Calculates the mean of wiggle files.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input wiggle files
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
