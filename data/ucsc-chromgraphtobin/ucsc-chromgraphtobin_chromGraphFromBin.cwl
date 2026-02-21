cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromGraphFromBin
label: ucsc-chromgraphtobin_chromGraphFromBin
doc: "The provided text contains a fatal error from the container runtime and does
  not include the help text or usage information for the tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chromgraphtobin:482--h0b57e2e_0
stdout: ucsc-chromgraphtobin_chromGraphFromBin.out
