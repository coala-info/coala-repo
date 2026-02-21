cwlVersion: v1.2
class: CommandLineTool
baseCommand: nasm
label: nasm
doc: "The Netwide Assembler (NASM), an assembler and disassembler for the Intel x86
  architecture.\n\nTool homepage: https://github.com/netwide-assembler/nasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasm:2.11.08--0
stdout: nasm.out
