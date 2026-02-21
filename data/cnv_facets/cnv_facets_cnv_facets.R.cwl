cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv_facets.R
label: cnv_facets_cnv_facets.R
doc: "The provided text contains container runtime error logs rather than tool help
  documentation. No arguments could be extracted.\n\nTool homepage: https://github.com/wwcrc/cnv_facets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-phenopacket:1.0.2
stdout: cnv_facets_cnv_facets.R.out
