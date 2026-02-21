cwlVersion: v1.2
class: CommandLineTool
baseCommand: nohuman
label: nohuman
doc: "A tool for removing human DNA sequences from metagenomic sequencing data.\n\n
  Tool homepage: https://github.com/mbhall88/nohuman"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nohuman:0.5.0--hbbf5808_0
stdout: nohuman.out
