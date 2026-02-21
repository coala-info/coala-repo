cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathoscope_sequencing
label: pathoscope_sequencing
doc: "Running without mySQLdb library\n\nTool homepage: https://github.com/PathoScope/PathoScope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
stdout: pathoscope_sequencing.out
