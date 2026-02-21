cwlVersion: v1.2
class: CommandLineTool
baseCommand: super_distance
label: super_distance
doc: "A tool for calculating distances (description not available in provided text)\n
  \nTool homepage: https://github.com/quadram-institute-bioscience/super_distance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/super_distance:1.1.0--h577a1d6_6
stdout: super_distance.out
