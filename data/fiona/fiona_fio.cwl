cwlVersion: v1.2
class: CommandLineTool
baseCommand: fio
label: fiona_fio
doc: "Fiona is a Python tool for reading and writing geographic data files. (Note:
  The provided text contains system error logs rather than help documentation.)\n\n
  Tool homepage: https://github.com/Toblerity/Fiona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio.out
