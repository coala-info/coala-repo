cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamdbg
label: metamdbg
doc: "A tool for metagenome assembly using de Bruijn graphs. (Note: The provided input
  text contains container runtime error messages and does not list specific command-line
  arguments or usage instructions).\n\nTool homepage: https://github.com/GaetanBenoitDev/metaMDBG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamdbg:1.3--h077b44d_0
stdout: metamdbg.out
