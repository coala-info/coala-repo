cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcontact2
label: vcontact2
doc: "vContact2 is a tool for classifying viral contigs into clusters (viral clusters,
  VCs) and taxonomic groups.\n\nTool homepage: https://bitbucket.org/MAVERICLab/vcontact2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcontact2:0.11.3--pyhdfd78af_0
stdout: vcontact2.out
