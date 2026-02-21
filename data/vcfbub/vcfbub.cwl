cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfbub
label: vcfbub
doc: "The provided text does not contain help information or usage instructions for
  vcfbub. It contains container runtime error messages.\n\nTool homepage: https://github.com/pangenome/vcfbub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfbub:0.1.2--hc1c3326_1
stdout: vcfbub.out
