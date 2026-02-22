cwlVersion: v1.2
class: CommandLineTool
baseCommand: pepnovop
label: pepnovop
doc: 'PepNovo+ is a tool for de novo peptide sequencing from MS/MS spectra. (Note:
  The provided help text contains only system error messages and does not list specific
  command-line arguments.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pepnovop:20120423
stdout: pepnovop.out
