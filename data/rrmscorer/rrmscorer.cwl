cwlVersion: v1.2
class: CommandLineTool
baseCommand: rrmscorer
label: rrmscorer
doc: "A tool for scoring RNA-Recognition Motif (RRM)-RNA interactions (Note: The provided
  text is a container build error log and does not contain CLI help information).\n
  \nTool homepage: https://bio2byte.be/rrmscorer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rrmscorer:1.0.11--pyhdfd78af_0
stdout: rrmscorer.out
