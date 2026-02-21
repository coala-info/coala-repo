cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedIntersect
label: ucsc-bedintersect
doc: "The provided text is a system error log (no space left on device) and does not
  contain the help documentation for ucsc-bedintersect. As a result, arguments and
  tool descriptions could not be extracted from the input.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedintersect:482--h0b57e2e_0
stdout: ucsc-bedintersect.out
