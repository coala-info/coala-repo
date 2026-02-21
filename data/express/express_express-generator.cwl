cwlVersion: v1.2
class: CommandLineTool
baseCommand: express
label: express_express-generator
doc: "eXpress is a streaming tool for quantifying the abundance of a set of target
  sequences from sampled subsequences (RNA-Seq reads).\n\nTool homepage: https://github.com/expressjs/express"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/express:1.5.1--h7d875b9_3
stdout: express_express-generator.out
