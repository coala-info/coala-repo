cwlVersion: v1.2
class: CommandLineTool
baseCommand: getorganelle
label: getorganelle
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container execution and
  disk space.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle.out
