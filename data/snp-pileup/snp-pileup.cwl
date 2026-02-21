cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-pileup
label: snp-pileup
doc: "The provided text does not contain help information or a description of the
  tool; it is a container engine error log.\n\nTool homepage: https://github.com/mskcc/facets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-pileup:0.6.2--h503566f_8
stdout: snp-pileup.out
