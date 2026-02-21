cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapgreen
label: rapgreen
doc: "Phylogenetic tree reconciliation and analysis tool.\n\nTool homepage: https://github.com/SouthGreenPlatform/rap-green"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapgreen:1.0--hdfd78af_0
stdout: rapgreen.out
