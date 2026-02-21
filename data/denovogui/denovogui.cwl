cwlVersion: v1.2
class: CommandLineTool
baseCommand: denovogui
label: denovogui
doc: "DeNovoGUI is a tool for de novo sequencing of tandem mass spectra. (Note: The
  provided text contains only system error messages and no help documentation.)\n\n
  Tool homepage: https://github.com/CompOmics/denovogui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/denovogui:v1.10.4_cv4
stdout: denovogui.out
