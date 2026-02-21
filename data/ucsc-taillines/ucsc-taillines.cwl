cwlVersion: v1.2
class: CommandLineTool
baseCommand: tailLines
label: ucsc-taillines
doc: "A UCSC Genome Browser utility to output the last N lines of a file.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-taillines:482--h0b57e2e_0
stdout: ucsc-taillines.out
