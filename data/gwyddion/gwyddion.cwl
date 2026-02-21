cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwyddion
label: gwyddion
doc: "Gwyddion is a modular program for SPM (scanning probe microscopy) data visualization
  and analysis.\n\nTool homepage: https://github.com/christian-sahlmann/gwyddion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwyddion:v2.52-1-deb_cv1
stdout: gwyddion.out
