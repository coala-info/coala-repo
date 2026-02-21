cwlVersion: v1.2
class: CommandLineTool
baseCommand: pling
label: pling
doc: "Pling is a tool for identifying and analyzing plasmids (Note: The provided text
  is an error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/iqbal-lab-org/pling"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pling:2.0.1--pyhdfd78af_0
stdout: pling.out
