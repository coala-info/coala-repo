cwlVersion: v1.2
class: CommandLineTool
baseCommand: braker
label: braker
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/Gaius-Augustus/BRAKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/braker:1.9--1
stdout: braker.out
