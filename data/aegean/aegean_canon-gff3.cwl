cwlVersion: v1.2
class: CommandLineTool
baseCommand: canon-gff3
label: aegean_canon-gff3
doc: "The provided text does not contain help information for the tool, as it describes
  a system error (no space left on device) during a container image extraction process.\n
  \nTool homepage: https://github.com/BrendelGroup/AEGeAn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
stdout: aegean_canon-gff3.out
