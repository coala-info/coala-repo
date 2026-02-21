cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite_hhsuitedb.py
label: hhsuite_hhsuitedb.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding container image conversion and disk space issues.\n
  \nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_hhsuitedb.py.out
