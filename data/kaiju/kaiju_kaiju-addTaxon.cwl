cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-addTaxon
label: kaiju_kaiju-addTaxon
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to pull the container image due to lack
  of disk space.\n\nTool homepage: https://kaiju.binf.ku.dk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-addTaxon.out
