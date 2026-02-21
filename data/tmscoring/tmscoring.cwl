cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmscoring
label: tmscoring
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/Dapid/tmscoring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmscoring:0.4.post0--pyhdc42f0e_0
stdout: tmscoring.out
