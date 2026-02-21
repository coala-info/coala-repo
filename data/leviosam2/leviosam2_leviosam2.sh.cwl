cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam2_leviosam2.sh
label: leviosam2_leviosam2.sh
doc: "LevioSAM2 is a tool for lifting over genomic coordinates. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/milkschen/leviosam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h4ac6f70_0
stdout: leviosam2_leviosam2.sh.out
