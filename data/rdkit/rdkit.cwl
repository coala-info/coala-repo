cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdkit
label: rdkit
doc: "The provided text is a system log indicating a failure to fetch or build a container
  image for RDKit and does not contain CLI help information or argument definitions.\n
  \nTool homepage: https://github.com/rdkit/rdkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdkit:2021.03.4
stdout: rdkit.out
