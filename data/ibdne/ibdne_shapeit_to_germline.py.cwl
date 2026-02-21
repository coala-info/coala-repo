cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_shapeit_to_germline.py
label: ibdne_shapeit_to_germline.py
doc: "A script to convert SHAPEIT output format to GERMLINE format for use with IBDne.\n
  \nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_shapeit_to_germline.py.out
