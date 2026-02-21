cwlVersion: v1.2
class: CommandLineTool
baseCommand: tirmite
label: tirmite
doc: "The provided text is a system log/error message from a container build process
  and does not contain the help documentation for the 'tirmite' tool. As a result,
  no arguments or tool descriptions could be extracted.\n\nTool homepage: https://github.com/Adamtaranto/TIRmite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
stdout: tirmite.out
