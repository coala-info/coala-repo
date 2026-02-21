cwlVersion: v1.2
class: CommandLineTool
baseCommand: rich-msa
label: rich-msa
doc: "A tool for rich visualization of Multiple Sequence Alignments (MSA) in the terminal.\n
  \nTool homepage: https://github.com/althonos/rich-msa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rich-msa:0.1.0--pyhdfd78af_0
stdout: rich-msa.out
