cwlVersion: v1.2
class: CommandLineTool
baseCommand: pca
label: haplomap_pca
doc: "Perform reduction on the data dimension (rows)\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: dimension
    type:
      - 'null'
      - int
    doc: dimensions of reduction
    inputBinding:
      position: 101
      prefix: --dimension
  - id: input_file
    type: File
    doc: input file (M x N matrix)
    inputBinding:
      position: 101
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: output file (L x N matrix)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
