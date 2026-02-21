cwlVersion: v1.2
class: CommandLineTool
baseCommand: snvphyl-tools
label: snvphyl-tools
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snvphyl-tools:1.8.2--pl5321h7b50bb2_9
stdout: snvphyl-tools.out
