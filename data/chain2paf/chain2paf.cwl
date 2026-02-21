cwlVersion: v1.2
class: CommandLineTool
baseCommand: chain2paf
label: chain2paf
doc: "Convert UCSC chain files to PAF (Pairwise Mapping Format)\n\nTool homepage:
  https://github.com/AndreaGuarracino/chain2paf"
inputs:
  - id: input_chain
    type: File
    doc: Input UCSC chain file to be converted
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chain2paf:0.1.1--h3ab6199_0
stdout: chain2paf.out
