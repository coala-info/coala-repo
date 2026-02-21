cwlVersion: v1.2
class: CommandLineTool
baseCommand: pourrna
label: pourrna
doc: "A tool for RNA secondary structure analysis (Note: The provided text is a container
  build log and does not contain specific usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/ViennaRNA/pourRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pourrna:1.2.0--h4ac6f70_4
stdout: pourrna.out
