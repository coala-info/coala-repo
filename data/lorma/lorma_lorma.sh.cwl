cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorma_lorma.sh
label: lorma_lorma.sh
doc: "Long-read self-correction tool (Note: The provided text contains system error
  messages rather than help documentation).\n\nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorma:0.4--2
stdout: lorma_lorma.sh.out
