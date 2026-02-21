cwlVersion: v1.2
class: CommandLineTool
baseCommand: ndisasm
label: nasm_ndisasm
doc: "The Netwide Disassembler, an 80x86 binary file disassembler\n\nTool homepage:
  https://github.com/netwide-assembler/nasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasm:2.11.08--0
stdout: nasm_ndisasm.out
