cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaprob
label: metaprob
doc: "MetaProb is a tool for unsupervised binning of metagenomic reads.\n\nTool homepage:
  https://github.com/probcomp/metaprob"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaprob:2--boost1.61_1
stdout: metaprob.out
