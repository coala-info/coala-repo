cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv_facets
label: cnv_facets
doc: "The provided text does not contain help information for cnv_facets; it contains
  container runtime log messages and a fatal error regarding disk space.\n\nTool homepage:
  https://github.com/wwcrc/cnv_facets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-phenopacket:1.0.2
stdout: cnv_facets.out
