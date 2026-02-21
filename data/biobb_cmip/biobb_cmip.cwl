cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_cmip
label: biobb_cmip
doc: "Classical Molecular Interaction Potentials (CMIP) wrapper (Note: The provided
  help text contained only system error logs and no usage information).\n\nTool homepage:
  https://github.com/bioexcel/biobb_cmip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_cmip:5.2.1--pyhdfd78af_0
stdout: biobb_cmip.out
