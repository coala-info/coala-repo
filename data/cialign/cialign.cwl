cwlVersion: v1.2
class: CommandLineTool
baseCommand: cialign
label: cialign
doc: "Clean and inspect Multiple Sequence Alignments (MSAs). Note: The provided text
  appears to be a container execution error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/KatyBrown/CIAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cialign:1.1.4--pyhca03a8a_0
stdout: cialign.out
