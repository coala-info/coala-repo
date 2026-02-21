cwlVersion: v1.2
class: CommandLineTool
baseCommand: gottcha_bwa
label: gottcha_bwa
doc: "GOTTCHA (Genomic Origin Through Taxonomic CHAllenge) is a taxonomic profiling
  tool. Note: The provided help text contains only system error messages regarding
  container runtime and disk space, and does not list command-line arguments.\n\n
  Tool homepage: https://github.com/poeli/GOTTCHA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha:1.0--pl526_2
stdout: gottcha_bwa.out
