cwlVersion: v1.2
class: CommandLineTool
baseCommand: idn2
label: libidn_idn2
doc: "Internationalized Domain Names (IDNA2008) conversion tool\n\nTool homepage:
  https://github.com/libidn/libidn2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libidn:7.45.0--1
stdout: libidn_idn2.out
