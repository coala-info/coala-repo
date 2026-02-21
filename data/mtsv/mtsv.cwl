cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv
label: mtsv
doc: "Metagenomics Taxon Selection and Verification\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py39h2de1943_5
stdout: mtsv.out
