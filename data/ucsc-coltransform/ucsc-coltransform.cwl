cwlVersion: v1.2
class: CommandLineTool
baseCommand: colTransform
label: ucsc-coltransform
doc: "A UCSC Genome Browser utility to transform columns in a file. (Note: The provided
  text contains container build errors rather than the tool's help output.)\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-coltransform:482--h0b57e2e_0
stdout: ucsc-coltransform.out
