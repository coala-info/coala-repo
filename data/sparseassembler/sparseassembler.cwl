cwlVersion: v1.2
class: CommandLineTool
baseCommand: SparseAssembler
label: sparseassembler
doc: "SparseAssembler is a de novo genome assembler. (Note: The provided input text
  appears to be a container runtime error log rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/yechengxi/SparseAssembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparseassembler:20160205--h9948957_11
stdout: sparseassembler.out
