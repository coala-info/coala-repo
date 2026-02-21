cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_ndx2resttop
label: biobb_gromacs_ndx2resttop
doc: "Generate a GROMACS restraint topology from an index file.\n\nTool homepage:
  https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_ndx2resttop.out
