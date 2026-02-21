cwlVersion: v1.2
class: CommandLineTool
baseCommand: ema
label: ema
doc: "Expediting Map-to-Alignment (EMA) is a tool for processing barcoded short-read
  sequencing data. (Note: The provided help text contains only system error messages
  and no usage information.)\n\nTool homepage: http://ema.csail.mit.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ema:0.7.0--h5ca1c30_2
stdout: ema.out
