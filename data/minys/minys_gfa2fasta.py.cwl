cwlVersion: v1.2
class: CommandLineTool
baseCommand: minys_gfa2fasta.py
label: minys_gfa2fasta.py
doc: "A tool to convert GFA (Graphical Fragment Assembly) files to FASTA format. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/cguyomar/MinYS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--h9948957_6
stdout: minys_gfa2fasta.py.out
