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
    default: TRef
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: output
    type: File
    doc: Path to save EPIC cell fractions (CSV/TSV)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
