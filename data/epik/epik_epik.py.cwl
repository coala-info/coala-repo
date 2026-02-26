cwlVersion: v1.2
class: CommandLineTool
baseCommand: epik.py
label: epik_epik.py
doc: "EPIK: Evolutionary Placement with Informative K-mers\n\nTool homepage: https://github.com/phylo42/epik"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., place)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epik:0.2.0--h077b44d_2
stdout: epik_epik.py.out
