cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-checkfcs
label: ig-checkfcs
doc: "A tool for checking FCS (Flow Cytometry Standard) files. (Note: The provided
  text contained only system error logs and no usage information; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/ImmPortDB/ig-checkfcs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkfcs:1.0.0--0
stdout: ig-checkfcs.out
