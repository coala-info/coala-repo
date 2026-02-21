cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrsim
label: lrsim
doc: "Linked Read Simulator (Note: The provided text is a container execution error
  message and does not contain the actual help documentation for the tool).\n\nTool
  homepage: https://github.com/aquaskyline/LRSIM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrsim:1.0--pl5321hbcd995c_0
stdout: lrsim.out
