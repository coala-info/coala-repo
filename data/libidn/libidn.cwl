cwlVersion: v1.2
class: CommandLineTool
baseCommand: idn
label: libidn
doc: "The libidn tool is used for Internationalized Domain Names (IDN) implementation.
  Note: The provided text appears to be a container runtime error log rather than
  help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/libidn/libidn2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libidn:7.45.0--1
stdout: libidn.out
