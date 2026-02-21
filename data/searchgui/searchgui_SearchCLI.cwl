cwlVersion: v1.2
class: CommandLineTool
baseCommand: SearchCLI
label: searchgui_SearchCLI
doc: "SearchGUI is a tool for protein identification. (Note: The provided text is
  a system error log and does not contain CLI help information.)\n\nTool homepage:
  https://github.com/CompOmics/searchgui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_SearchCLI.out
