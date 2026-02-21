cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdrf-pipelines
label: sdrf-pipelines
doc: "The provided text is an error log from a container runtime failure and does
  not contain help information or usage instructions for the sdrf-pipelines tool.\n
  \nTool homepage: https://github.com/bigbio/sdrf-pipelines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdrf-pipelines:0.0.33--pyhdfd78af_0
stdout: sdrf-pipelines.out
