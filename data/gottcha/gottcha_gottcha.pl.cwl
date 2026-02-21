cwlVersion: v1.2
class: CommandLineTool
baseCommand: gottcha_gottcha.pl
label: gottcha_gottcha.pl
doc: "GOTTCHA (Genomic Origin Through Taxonomic CHAllenge) is a taxonomic profiling
  tool.\n\nTool homepage: https://github.com/poeli/GOTTCHA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha:1.0--pl526_2
stdout: gottcha_gottcha.pl.out
