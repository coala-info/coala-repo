cwlVersion: v1.2
class: CommandLineTool
baseCommand: lightassembler
label: lightassembler
doc: "LightAssembler is a lightweight genome assembler. (Note: The provided text contains
  container runtime error logs rather than help documentation, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/SaraEl-Metwally/LightAssembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightassembler:1.0--hd03093a_3
stdout: lightassembler.out
