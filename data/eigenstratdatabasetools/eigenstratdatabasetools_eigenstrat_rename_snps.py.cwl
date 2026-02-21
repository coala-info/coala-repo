cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - eigenstrat_rename_snps.py
label: eigenstratdatabasetools_eigenstrat_rename_snps.py
doc: "A tool from the eigenstratdatabasetools suite to rename SNPs. Note: The provided
  help text contains system error messages and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/TCLamnidis/EigenStratDatabaseTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigenstratdatabasetools:1.1.0--hdfd78af_0
stdout: eigenstratdatabasetools_eigenstrat_rename_snps.py.out
