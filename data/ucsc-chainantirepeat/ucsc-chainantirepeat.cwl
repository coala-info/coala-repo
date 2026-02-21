cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainAntiRepeat
label: ucsc-chainantirepeat
doc: "The provided text is a container runtime error message and does not contain
  help documentation for the tool. chainAntiRepeat is a UCSC Genome Browser utility
  used to filter out genomic alignments (chains) that consist primarily of repeats.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainantirepeat:482--h0b57e2e_0
stdout: ucsc-chainantirepeat.out
