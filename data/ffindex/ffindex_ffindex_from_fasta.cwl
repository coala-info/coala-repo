cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_from_fasta
label: ffindex_ffindex_from_fasta
doc: "The provided help text contains only system error messages related to a container
  runtime failure ('no space left on device') and does not include usage information
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_from_fasta.out
