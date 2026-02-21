cwlVersion: v1.2
class: CommandLineTool
baseCommand: searchgui_PathSettingsCLI
label: searchgui_PathSettingsCLI
doc: "The provided text contains system log information and error messages regarding
  a container build failure ('no space left on device') rather than the help text
  for the tool. Consequently, no arguments could be extracted from the provided input.\n
  \nTool homepage: https://github.com/CompOmics/searchgui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_PathSettingsCLI.out
