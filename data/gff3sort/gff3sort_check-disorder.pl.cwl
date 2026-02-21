cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3sort_check-disorder.pl
label: gff3sort_check-disorder.pl
doc: "A script to check if a GFF3 file is properly sorted. (Note: The provided input
  text was a system error message and did not contain help documentation; no arguments
  could be extracted.)\n\nTool homepage: https://github.com/billzt/gff3sort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3sort:0.1.a1a2bc9--pl526_0
stdout: gff3sort_check-disorder.pl.out
