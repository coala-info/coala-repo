cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_chemistry
label: biobb_chemistry
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image extraction (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_chemistry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_chemistry:5.2.0--pyhdfd78af_0
stdout: biobb_chemistry.out
