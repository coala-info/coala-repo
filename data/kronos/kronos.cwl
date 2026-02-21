cwlVersion: v1.2
class: CommandLineTool
baseCommand: kronos
label: kronos
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help text or argument definitions for the tool 'kronos'.\n\n
  Tool homepage: https://github.com/jtaghiyar/kronos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0
stdout: kronos.out
