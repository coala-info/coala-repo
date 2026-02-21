cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraview
label: paraview
doc: "\nTool homepage: https://github.com/Kitware/ParaView"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paraview:5.2.0--py27_1
stdout: paraview.out
