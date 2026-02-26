cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy log2_eset
label: iobrpy_log2_eset
doc: "Applies log2(x+1) transformation to an expression set matrix.\n\nTool homepage:
  https://github.com/IOBR/IOBRpy"
inputs:
  - id: input_matrix
    type: File
    doc: "Path to input matrix (CSV/TSV/TXT, optionally .gz).\n                  \
      \      Rows=genes, cols=samples."
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_matrix
    type: File
    doc: "Path to save the log2(x+1) matrix. Extension selects\n                 \
      \       delimiter (.csv/.tsv or mirror input)."
    outputBinding:
      glob: $(inputs.output_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
