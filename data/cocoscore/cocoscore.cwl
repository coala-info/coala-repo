cwlVersion: v1.2
class: CommandLineTool
baseCommand: cocoscore
label: cocoscore
doc: "A tool for scoring protein-protein interactions (description not available in
  provided text)\n\nTool homepage: https://github.com/JungeAlexander/cocoscore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cocoscore:1.0.0--pyhdfd78af_1
stdout: cocoscore.out
