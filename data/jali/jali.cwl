cwlVersion: v1.2
class: CommandLineTool
baseCommand: jali
label: jali
doc: "Joint Alignment of Large-scale genomic sequences (Note: The provided text contains
  system error logs and does not include usage instructions or argument definitions).\n
  \nTool homepage: http://bibiserv.cebitec.uni-bielefeld.de/jali"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jali:1.3--0
stdout: jali.out
