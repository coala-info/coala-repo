cwlVersion: v1.2
class: CommandLineTool
baseCommand: pepnovo
label: pepnovo
doc: "PepNovo is a tool for de novo peptide sequencing from MS/MS spectra. (Note:
  The provided help text contains only system error messages and no argument definitions).\n\
  \nTool homepage: https://github.com/jmchilton/pepnovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pepnovo:v20120423_cv3
stdout: pepnovo.out
