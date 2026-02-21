cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_solvate
label: biobb_gromacs_solvate
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  extraction (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_solvate.out
