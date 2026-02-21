cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdesigner_mkselect
label: mkdesigner_mkselect
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding disk space during a
  container build process.\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.2--pyhdfd78af_0
stdout: mkdesigner_mkselect.out
