cwlVersion: v1.2
class: CommandLineTool
baseCommand: BAMscale
label: bamscale_BAMscale
doc: "a tool to quantify peaks, and scale sequencing data\n\nTool homepage: https://github.com/ncbi/BAMscale"
inputs:
  - id: command
    type: string
    doc: Command to execute (cov or scale)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamscale:0.0.9--hf9495ce_0
stdout: bamscale_BAMscale.out
