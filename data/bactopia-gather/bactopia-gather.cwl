cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-gather
label: bactopia-gather
doc: "The provided text is a system error log (out of disk space) and does not contain
  help information or usage instructions for the tool.\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-gather:1.0.4--hdfd78af_0
stdout: bactopia-gather.out
