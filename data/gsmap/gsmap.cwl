cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap
label: gsmap
doc: "GSMap (Note: The provided text contains container execution logs and error messages
  rather than tool help text; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/LeonSong1995/gsMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.6--pyhdfd78af_0
stdout: gsmap.out
