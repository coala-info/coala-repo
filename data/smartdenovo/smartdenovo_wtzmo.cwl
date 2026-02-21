cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtzmo
label: smartdenovo_wtzmo
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container execution attempt.\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_wtzmo.out
