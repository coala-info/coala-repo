cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain
label: nextstrain
doc: "The provided text appears to be a system error log regarding a container execution
  failure (no space left on device) rather than CLI help text. Consequently, no arguments
  or tool descriptions could be extracted.\n\nTool homepage: https://nextstrain.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_2
stdout: nextstrain.out
