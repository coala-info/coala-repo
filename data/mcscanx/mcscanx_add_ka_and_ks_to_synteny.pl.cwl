cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcscanx_add_ka_and_ks_to_synteny.pl
label: mcscanx_add_ka_and_ks_to_synteny.pl
doc: "A script to add Ka (nonsynonymous substitution rate) and Ks (synonymous substitution
  rate) values to synteny results.\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_add_ka_and_ks_to_synteny.pl.out
