cwlVersion: v1.2
class: CommandLineTool
baseCommand: cas-offinder
label: cas-offinder
doc: "Cas-offinder is a tool that searches for potential off-target sites of CRISPR/Cas9
  RNA-guided endonucleases.\n\nTool homepage: https://github.com/snugel/cas-offinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cas-offinder:2.4.1--h503566f_0
stdout: cas-offinder.out
