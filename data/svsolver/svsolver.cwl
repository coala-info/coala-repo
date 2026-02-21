cwlVersion: v1.2
class: CommandLineTool
baseCommand: svsolver
label: svsolver
doc: "Structural variant solver (Note: The provided text contains container build
  logs and error messages rather than CLI help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://simtk.org/projects/simvascular/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
stdout: svsolver.out
