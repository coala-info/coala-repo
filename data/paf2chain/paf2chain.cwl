cwlVersion: v1.2
class: CommandLineTool
baseCommand: paf2chain
label: paf2chain
doc: "Convert PAF format alignments to CHAIN format\n\nTool homepage: https://github.com/AndreaGuarracino/paf2chain"
inputs:
  - id: input
    type: File
    doc: Input PAF file
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paf2chain:0.1.1--h3ab6199_0
stdout: paf2chain.out
