cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar
label: olivar
doc: "The provided text is an error log from a container runtime and does not contain
  help information or argument definitions for the 'olivar' tool.\n\nTool homepage:
  https://gitlab.com/treangenlab/olivar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_3
stdout: olivar.out
