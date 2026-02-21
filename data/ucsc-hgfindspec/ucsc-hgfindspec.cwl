cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-hgfindspec
label: ucsc-hgfindspec
doc: "The provided text does not contain help information for the tool. It contains
  log messages and a fatal error related to a container image build failure.\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfindspec:482--h0b57e2e_0
stdout: ucsc-hgfindspec.out
