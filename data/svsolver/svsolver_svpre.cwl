cwlVersion: v1.2
class: CommandLineTool
baseCommand: svsolver_svpre
label: svsolver_svpre
doc: "The provided text does not contain help information for svsolver_svpre; it contains
  container runtime logs and a fatal error message regarding image fetching.\n\nTool
  homepage: https://simtk.org/projects/simvascular/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
stdout: svsolver_svpre.out
