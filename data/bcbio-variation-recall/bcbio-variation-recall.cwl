cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-variation-recall
label: bcbio-variation-recall
doc: "A tool for calling variants from multiple samples using a graph-based representation
  of the reference genome and known variations.\n\nTool homepage: https://github.com/chapmanb/bcbio.variation.recall"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-variation-recall:0.2.6--hdfd78af_1
stdout: bcbio-variation-recall.out
