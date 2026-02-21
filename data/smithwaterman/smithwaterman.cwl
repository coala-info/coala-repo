cwlVersion: v1.2
class: CommandLineTool
baseCommand: smithwaterman
label: smithwaterman
doc: "A tool for performing Smith-Waterman local sequence alignment.\n\nTool homepage:
  https://github.com/ekg/smithwaterman"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smithwaterman:1.0.0--h9948957_0
stdout: smithwaterman.out
