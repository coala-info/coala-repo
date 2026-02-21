cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-codon-alignment
label: extract-codon-alignment
doc: "A tool to extract codon alignments (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/linzhi2013/extract_codon_alignment"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
stdout: extract-codon-alignment.out
