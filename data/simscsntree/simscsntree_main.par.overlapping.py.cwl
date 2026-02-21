cwlVersion: v1.2
class: CommandLineTool
baseCommand: simscsntree_main.par.overlapping.py
label: simscsntree_main.par.overlapping.py
doc: "The provided text is a container build error log and does not contain help information
  or usage instructions for the tool.\n\nTool homepage: https://github.com/compbiofan/SimSCSnTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simscsntree:0.0.9--pyh5e36f6f_0
stdout: simscsntree_main.par.overlapping.py.out
