cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipits
label: pipits
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log related to a Singularity/Apptainer container execution
  failure.\n\nTool homepage: https://github.com/hsgweon/pipits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipits:4.0--pyhdfd78af_1
stdout: pipits.out
