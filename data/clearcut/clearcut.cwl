cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearcut
label: clearcut
doc: "A tool for phylogenetic tree reconstruction using the Relaxed Neighbor-Joining
  (RNJ) algorithm.\n\nTool homepage: https://github.com/DavidJBianco/Clearcut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clearcut:v1.0.9-3-deb_cv1
stdout: clearcut.out
