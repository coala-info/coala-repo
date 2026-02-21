cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - asm
label: biscuit_asm
doc: "BISCUIT assembly subcommand for processing epiread files\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: input_epiread
    type: File
    doc: Input epiread file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_asm.out
