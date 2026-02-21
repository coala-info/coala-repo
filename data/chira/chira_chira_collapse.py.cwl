cwlVersion: v1.2
class: CommandLineTool
baseCommand: chira_chira_collapse.py
label: chira_chira_collapse.py
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build process due to insufficient disk space.\n\nTool homepage:
  https://github.com/pavanvidem/chira/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
stdout: chira_chira_collapse.py.out
