cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnavirhost classify_order
label: rnavirhost_classify_order
doc: "Classifier query viruses at order level\n\nTool homepage: https://github.com/GreyGuoweiChen/VirHost.git"
inputs:
  - id: input
    type: File
    doc: The name of query fasta file.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: The output taxonomic file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnavirhost:1.0.5--pyh7cba7a3_0
