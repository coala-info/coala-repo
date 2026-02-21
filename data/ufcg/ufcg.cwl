cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg
label: ufcg
doc: "\nTool homepage: https://ufcg.steineggerlab.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
stdout: ufcg.out
