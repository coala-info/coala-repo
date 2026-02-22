cwlVersion: v1.2
class: CommandLineTool
baseCommand: bx-tools
label: bx-tools
doc: "The provided text does not contain help information or usage instructions for
  bx-tools. It contains system error messages related to a lack of disk space during
  a container image pull/conversion process.\n\nTool homepage: https://github.com/bx/elf-bf-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bx-tools:v0.8.2-1-deb-py2_cv1
stdout: bx-tools.out
