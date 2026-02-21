cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotohscan
label: gotohscan
doc: "GotohScan is a tool for searching sequences using the Gotoh alignment algorithm
  (Note: The provided help text contains only container runtime error messages and
  no usage information).\n\nTool homepage: http://www.bioinf.uni-leipzig.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotohscan:2.0--h7b50bb2_0
stdout: gotohscan.out
