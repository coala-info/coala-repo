cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdesigner_mkvcf
label: mkdesigner_mkvcf
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building (no space left on device).\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.2--pyhdfd78af_0
stdout: mkdesigner_mkvcf.out
