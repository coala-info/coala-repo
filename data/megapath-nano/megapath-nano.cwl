cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath-nano
label: megapath-nano
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building.\n\nTool homepage: https://github.com/HKU-BAL/MegaPath-Nano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
stdout: megapath-nano.out
