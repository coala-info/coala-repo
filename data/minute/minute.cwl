cwlVersion: v1.2
class: CommandLineTool
baseCommand: minute
label: minute
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the 'minute' tool.\n\nTool homepage:
  https://github.com/NBISweden/minute/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
stdout: minute.out
