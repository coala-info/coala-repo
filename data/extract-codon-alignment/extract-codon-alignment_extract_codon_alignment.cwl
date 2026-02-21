cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-codon-alignment
label: extract-codon-alignment_extract_codon_alignment
doc: "A tool for extracting codon alignments (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/linzhi2013/extract_codon_alignment"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
stdout: extract-codon-alignment_extract_codon_alignment.out
