cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadWiggle
label: ucsc-hgloadwiggle
doc: "Load a wiggle file into a database (Note: The provided help text contains only
  container runtime error logs and no usage information).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadwiggle:482--h0b57e2e_0
stdout: ucsc-hgloadwiggle.out
