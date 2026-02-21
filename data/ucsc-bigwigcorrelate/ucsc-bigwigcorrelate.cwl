cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigCorrelate
label: ucsc-bigwigcorrelate
doc: "A tool from the UCSC Genome Browser utilities to correlate two bigWig files.
  (Note: The provided help text contained a system error message rather than tool
  usage instructions.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigcorrelate:482--h0b57e2e_0
stdout: ucsc-bigwigcorrelate.out
