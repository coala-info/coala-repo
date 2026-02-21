cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecko
label: gecko
doc: "Gecko (Genome Evolution and Comparison Tool). Note: The provided text is a container
  runtime error log and does not contain help documentation or argument definitions.\n
  \nTool homepage: https://github.com/otorreno/gecko"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
stdout: gecko.out
