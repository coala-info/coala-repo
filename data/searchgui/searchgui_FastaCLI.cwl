cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - searchgui
  - FastaCLI
label: searchgui_FastaCLI
doc: "Note: The provided text does not contain help information or usage instructions.
  It contains system error logs regarding a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/CompOmics/searchgui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_FastaCLI.out
