cwlVersion: v1.2
class: CommandLineTool
baseCommand: svsolver
label: svsolver
doc: "Solver Input Files listed as below:\n\nTool homepage: https://simtk.org/projects/simvascular/"
inputs:
  - id: local_config
    type: File
    doc: 'Local Config: solver.inp'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
stdout: svsolver.out
