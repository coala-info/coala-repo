cwlVersion: v1.2
class: CommandLineTool
baseCommand: Bandage
label: bandage_Bandage
doc: "Launch the Bandage GUI\n\nTool homepage: https://github.com/rrwick/Bandage"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute (e.g., load, info, image, querypaths, reduce). If 
      blank, launches the GUI.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage:0.9.0--h9948957_0
stdout: bandage_Bandage.out
