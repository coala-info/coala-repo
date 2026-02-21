cwlVersion: v1.2
class: CommandLineTool
baseCommand: wordLine
label: ucsc-wordline
doc: "A tool from the UCSC Genome Browser toolset (Note: The provided input text contained
  container build errors rather than help text; arguments could not be extracted from
  the source).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wordline:482--h0b57e2e_0
stdout: ucsc-wordline.out
