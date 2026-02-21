cwlVersion: v1.2
class: CommandLineTool
baseCommand: HLA-ASM.pl
label: hla-asm_HLA-ASM.pl
doc: "HLA-ASM: A tool for HLA assembly. (Note: The provided help text contains only
  system error messages and does not list usage instructions or arguments.)\n\nTool
  homepage: https://github.com/DiltheyLab/HLA-LA/blob/master/HLA-ASM.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-asm:1.0.1--pl5321hdfd78af_0
stdout: hla-asm_HLA-ASM.pl.out
