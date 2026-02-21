cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_grompp
label: biobb_gromacs_grompp
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build process and does not contain help information
  or argument definitions for the tool.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_grompp.out
