cwlVersion: v1.2
class: CommandLineTool
baseCommand: minys_MinYS.py
label: minys_MinYS.py
doc: "MinYS (Mine Your Symbiont) is a tool for the assembly of minor components in
  metagenomes. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/cguyomar/MinYS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--h9948957_6
stdout: minys_MinYS.py.out
