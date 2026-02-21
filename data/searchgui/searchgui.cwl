cwlVersion: v1.2
class: CommandLineTool
baseCommand: searchgui
label: searchgui
doc: "The provided text is an error log regarding a container build failure (no space
  left on device) and does not contain help text or command-line argument definitions.\n
  \nTool homepage: https://github.com/CompOmics/searchgui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui.out
