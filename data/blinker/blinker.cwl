cwlVersion: v1.2
class: CommandLineTool
baseCommand: blinker
label: blinker
doc: "The provided text does not contain help documentation for the tool; it consists
  of system error messages related to a failed container image download (no space
  left on device).\n\nTool homepage: https://github.com/blinksh/blink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker.out
