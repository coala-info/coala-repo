cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigCorrelate
label: ucsc-bigwigcorrelate
doc: "Correlate two or more bigWig files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: bigwig_files
    type:
      type: array
      items: File
    doc: The bigWig files to correlate.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigcorrelate:482--h0b57e2e_0
stdout: ucsc-bigwigcorrelate.out
