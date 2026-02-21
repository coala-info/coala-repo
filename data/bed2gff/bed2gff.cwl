cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed2gff
label: bed2gff
doc: "The provided text does not contain help information or usage instructions for
  bed2gff. It appears to be a system error log related to a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/alejandrogzi/bed2gff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bed2gff:0.1.5--h9948957_1
stdout: bed2gff.out
