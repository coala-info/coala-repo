cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-teton
label: bactopia-teton
doc: "The provided text contains system error messages (Singularity/Docker image pull
  failure) rather than the tool's help documentation. As a result, no arguments or
  functional descriptions could be extracted.\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-teton:1.1.1--hdfd78af_0
stdout: bactopia-teton.out
