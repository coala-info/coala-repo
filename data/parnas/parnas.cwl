cwlVersion: v1.2
class: CommandLineTool
baseCommand: parnas
label: parnas
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or run a Singularity container
  due to insufficient disk space.\n\nTool homepage: https://github.com/flu-crew/parnas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parnas:0.1.7--pyhdfd78af_1
stdout: parnas.out
