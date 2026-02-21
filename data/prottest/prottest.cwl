cwlVersion: v1.2
class: CommandLineTool
baseCommand: prottest
label: prottest
doc: "The provided text does not contain help information for prottest; it is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/ddarriba/prottest3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/prottest:v3.4.2dfsg-3-deb_cv1
stdout: prottest.out
