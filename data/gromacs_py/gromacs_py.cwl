cwlVersion: v1.2
class: CommandLineTool
baseCommand: gromacs_py
label: gromacs_py
doc: "The provided text contains system error logs and environment information rather
  than tool help text. No command-line arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_py.out
