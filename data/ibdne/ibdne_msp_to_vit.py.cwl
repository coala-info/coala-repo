cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_msp_to_vit.py
label: ibdne_msp_to_vit.py
doc: "A tool to convert MSP files to VIT format. (Note: The provided help text contains
  only system error messages and does not list specific arguments or usage instructions.)\n
  \nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_msp_to_vit.py.out
