cwlVersion: v1.2
class: CommandLineTool
baseCommand: dunovo
label: dunovo
doc: "Duplex sequencing pipeline (Note: The provided text contains system error messages
  regarding container building and does not include usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo.out
