cwlVersion: v1.2
class: CommandLineTool
baseCommand: eigenstrat_database_tools.py
label: eigenstratdatabasetools_eigenstrat_database_tools.py
doc: "A tool for managing Eigenstrat databases. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/TCLamnidis/EigenStratDatabaseTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigenstratdatabasetools:1.1.0--hdfd78af_0
stdout: eigenstratdatabasetools_eigenstrat_database_tools.py.out
