cwlVersion: v1.2
class: CommandLineTool
baseCommand: teloclip
label: teloclip
doc: "A tool for telomere-based clipping of long-read sequences (No help text provided
  in input)\n\nTool homepage: https://github.com/Adamtaranto/teloclip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
stdout: teloclip.out
