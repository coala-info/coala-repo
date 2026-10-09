cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - IPS
label: iobrpy_IPS
doc: "Calculate the Immunophenoscore (IPS) from an expression matrix.\n\nTool homepage:
  https://github.com/IOBR/IOBRpy"
inputs:
  - id: input_path
    type: File
    doc: Path to expression matrix file (e.g., EXPR.txt)
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path_path
    type: string
    doc: Path to save IPS results (e.g., IPS_results.txt)
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_path
    type: File
    doc: Path to save IPS results (e.g., IPS_results.txt)
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
