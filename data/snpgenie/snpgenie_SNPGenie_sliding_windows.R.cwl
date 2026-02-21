cwlVersion: v1.2
class: CommandLineTool
baseCommand: SNPGenie_sliding_windows.R
label: snpgenie_SNPGenie_sliding_windows.R
doc: "SNPGenie sliding windows analysis script. Note: The provided help text contains
  only system error messages and does not list available arguments.\n\nTool homepage:
  https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_SNPGenie_sliding_windows.R.out
