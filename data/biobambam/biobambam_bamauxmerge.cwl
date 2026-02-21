cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamauxmerge
label: biobambam_bamauxmerge
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamauxmerge.out
