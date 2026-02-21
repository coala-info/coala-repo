cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalt
label: smalt_smalte
doc: "SMALT is a tool for mapping DNA sequencing reads onto a reference genome.\n\n
  Tool homepage: https://github.com/roquie/smalte"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
stdout: smalt_smalte.out
