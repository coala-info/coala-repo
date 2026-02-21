cwlVersion: v1.2
class: CommandLineTool
baseCommand: guppy
label: pplacer_guppy
doc: "The provided text contains container execution logs and error messages rather
  than tool help text. No usage information or arguments could be extracted.\n\nTool
  homepage: http://matsen.fredhutch.org/pplacer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pplacer:1.1.alpha17--0
stdout: pplacer_guppy.out
