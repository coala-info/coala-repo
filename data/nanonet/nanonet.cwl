cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanonet
label: nanonet
doc: "A tool for Oxford Nanopore sequencing data analysis (Note: The provided text
  contains container runtime errors and does not include the actual help documentation).\n
  \nTool homepage: https://github.com/abhyantrika/nanonets_object_tracking"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanonet:2.0.0--boost1.64_0
stdout: nanonet.out
