cwlVersion: v1.2
class: CommandLineTool
baseCommand: edfbrowser
label: edfbrowser
doc: "A free, open-source, multiplatform universal viewer and toolbox for time-series
  storage files like EDF, EDF+, BDF, BDF+, etc.\n\nTool homepage: https://github.com/RTMilliken/EDFbrowser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/edfbrowser:v1.58-1b1-deb_cv1
stdout: edfbrowser.out
