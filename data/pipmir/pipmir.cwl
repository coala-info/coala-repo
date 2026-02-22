cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipmir
label: pipmir
doc: "Pipmir is a pipeline for miRNA identification. (Note: The provided text contains
  system error messages regarding container execution and disk space, rather than
  the tool's help documentation. Consequently, no arguments could be extracted from
  the input.)\n\nTool homepage: https://github.com/PonomareVlad/PiPMirror"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipmir:1.1--hdfd78af_6
stdout: pipmir.out
