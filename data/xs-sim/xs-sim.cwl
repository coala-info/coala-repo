cwlVersion: v1.2
class: CommandLineTool
baseCommand: xs-sim
label: xs-sim
doc: "A cross-platform simulator for DNA sequencing data. (Note: The provided text
  is a container execution error log and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: https://github.com/pratas/xs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xs-sim:2--h7b50bb2_3
stdout: xs-sim.out
