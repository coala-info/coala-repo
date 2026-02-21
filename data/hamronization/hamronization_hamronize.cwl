cwlVersion: v1.2
class: CommandLineTool
baseCommand: hamronize
label: hamronization_hamronize
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
stdout: hamronization_hamronize.out
