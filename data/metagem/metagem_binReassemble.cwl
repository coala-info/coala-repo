cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagem_binReassemble
label: metagem_binReassemble
doc: "A tool for bin reassembly within the metagem suite. (Note: The provided text
  contains system error messages regarding container image building and does not include
  the actual help documentation or usage instructions.)\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_binReassemble.out
