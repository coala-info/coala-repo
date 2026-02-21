cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-chainsort
label: ucsc-chainsort
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container execution log showing a fatal error during
  the image build/fetch process.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainsort:482--h0b57e2e_0
stdout: ucsc-chainsort.out
