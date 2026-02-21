cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_emirge_rename_fasta.py
label: emirge_emirge_rename_fasta.py
doc: "A tool to rename FASTA files for EMIRGE. Note: The provided help text contains
  only system error messages regarding container image creation and does not list
  usage or arguments.\n\nTool homepage: https://github.com/csmiller/EMIRGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge_rename_fasta.py.out
