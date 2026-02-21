cwlVersion: v1.2
class: CommandLineTool
baseCommand: hla-asm
label: hla-asm
doc: "HLA assembly tool (Note: The provided text contains system error logs and does
  not list specific command-line arguments or usage instructions).\n\nTool homepage:
  https://github.com/DiltheyLab/HLA-LA/blob/master/HLA-ASM.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-asm:1.0.1--pl5321hdfd78af_0
stdout: hla-asm.out
