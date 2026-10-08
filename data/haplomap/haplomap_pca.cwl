cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplomap
  - pca
label: haplomap_pca
doc: "Perform reduction on the data dimension (rows)\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: dimension
    type:
      - 'null'
      - int
    doc: "dimensions of reduction, default 4."
    inputBinding:
      position: 1
      prefix: -d
  - id: input_file
    type: File
    doc: "input file (M x N matrix)"
    inputBinding:
      position: 1
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: "output file (L x N matrix)"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: "Reduced matrix"
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
