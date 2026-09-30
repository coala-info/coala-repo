cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - mcpcounter
label: iobrpy_mcpcounter
doc: "MCPcounter is a tool for estimating the abundance of immune cells in transcriptomic
  data.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: features
    type: string
    doc: Type of gene identifiers
    inputBinding:
      position: 101
      prefix: --features
  - id: input_path
    type: File
    doc: Path to input expression matrix (TSV, genes×samples)
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_path
    type: File
    doc: Path to save MCPcounter results (TSV)
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
