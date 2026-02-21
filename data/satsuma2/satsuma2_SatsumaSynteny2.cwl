cwlVersion: v1.2
class: CommandLineTool
baseCommand: SatsumaSynteny2
label: satsuma2_SatsumaSynteny2
doc: "SatsumaSynteny2 (Note: The provided help text contains container environment
  logs and error messages rather than tool usage information. No arguments could be
  extracted.)\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
stdout: satsuma2_SatsumaSynteny2.out
