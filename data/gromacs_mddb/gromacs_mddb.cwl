cwlVersion: v1.2
class: CommandLineTool
baseCommand: gromacs_mddb
label: gromacs_mddb
doc: "Note: The provided text contains system error logs regarding a container build
  failure (no space left on device) rather than the tool's help documentation. No
  arguments could be extracted.\n\nTool homepage: https://www.gromacs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb.out
