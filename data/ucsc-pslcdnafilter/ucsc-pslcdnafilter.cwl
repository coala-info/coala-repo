cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCDnaFilter
label: ucsc-pslcdnafilter
doc: "Filter cDNA alignments in PSL format. (Note: The provided text contains container
  runtime errors and does not include the tool's help documentation, so arguments
  could not be extracted.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcdnafilter:482--h0b57e2e_0
stdout: ucsc-pslcdnafilter.out
