cwlVersion: v1.2
class: CommandLineTool
baseCommand: ananse
label: ananse_ananse
doc: "ananse: error: argument {binding,network,influence,view,plot}: invalid choice:
  'ananse' (choose from 'binding', 'network', 'influence', 'view', 'plot')\n\nTool
  homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs:
  - id: command
    type: string
    doc: Command to run (binding, network, influence, view, plot)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
stdout: ananse_ananse.out
