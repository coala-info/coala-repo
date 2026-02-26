cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_peaks
doc: "Crux is a suite of tools for analyzing tandem mass spectrometry data.\n\nTool
  homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The primary or utility command to run.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_peaks.out
