cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmx
label: gromacs_mddb_gmx
doc: "GROMACS molecular dynamics software suite\n\nTool homepage: https://www.gromacs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb_gmx.out
