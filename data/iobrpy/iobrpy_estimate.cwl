cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - estimate
label: iobrpy_estimate
doc: "Estimate gene expression levels from raw count matrices.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: input_path
    type: File
    doc: Path to input matrix file (genes x samples)
    inputBinding:
      position: 101
      prefix: --input
  - id: platform
    type:
      - 'null'
      - string
    doc: Specify the platform type for the input data
    inputBinding:
      position: 101
      prefix: --platform
  - id: output_path_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_path
    type: File
    doc: Path to save estimate results
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
