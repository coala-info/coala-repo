cwlVersion: v1.2
class: CommandLineTool
baseCommand: metasv
label: metasv
doc: "MetaSV is an integrative structural variant caller. (Note: The provided text
  is an error log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/bioinform/metasv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasv:0.5.4--py27_1
stdout: metasv.out
