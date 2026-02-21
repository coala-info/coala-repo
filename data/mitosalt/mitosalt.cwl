cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitosalt
label: mitosalt
doc: "MitoSALT (Mitochondrial DNA Sequence Analysis and Long-read Toolkit) is a tool
  for mitochondrial DNA analysis. Note: The provided text contains system error messages
  regarding container image building and does not list specific command-line arguments.\n
  \nTool homepage: https://sourceforge.net/projects/mitosalt/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_2
stdout: mitosalt.out
