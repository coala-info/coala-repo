cwlVersion: v1.2
class: CommandLineTool
baseCommand: igv
label: igv
doc: "Integrative Genomics Viewer (IGV) is a high-performance visualization tool for
  interactive exploration of large, integrated genomic datasets.\n\nTool homepage:
  http://www.broadinstitute.org/software/igv/home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igv:2.19.7--h33ea123_0
stdout: igv.out
