cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy epic
label: iobrpy_epic
doc: "EPIC deconvolution tool\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: input
    type: File
    doc: Path to the bulk expression matrix (genes×samples)
    inputBinding:
      position: 101
      prefix: --input
  - id: reference
    type:
      - 'null'
      - string
    doc: Which reference to use for deconvolution
    inputBinding:
      position: 101
      prefix: --reference
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to save EPIC cell fractions (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
