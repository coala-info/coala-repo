cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastn_to_phandango
label: seer_blastn_to_phandango
doc: "Creates a plot file for visualisation in phandango\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: blast
    type: File
    doc: "Blast results"
    inputBinding:
      position: 1
      prefix: --blast
  - id: assoc
    type: File
    doc: "fastlmm results"
    inputBinding:
      position: 1
      prefix: --assoc
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_blastn_to_phandango.out
