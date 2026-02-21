cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmx
label: gromacs_gmx
doc: "GROMACS is a versatile package to perform molecular dynamics, i.e. simulate
  the Newtonian equations of motion for systems with hundreds to millions of particles.\n
  \nTool homepage: https://www.gromacs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_gmx.out
