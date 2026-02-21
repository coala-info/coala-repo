cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbdraw
label: gbdraw
doc: "A tool for drawing GenBank files (Note: The provided text contains container
  runtime error messages rather than help text, so arguments could not be extracted).\n
  \nTool homepage: https://github.com/satoshikawato/gbdraw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbdraw:0.8.0--pyhdfd78af_0
stdout: gbdraw.out
