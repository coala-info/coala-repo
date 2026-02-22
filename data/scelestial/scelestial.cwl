cwlVersion: v1.2
class: CommandLineTool
baseCommand: scelestial
label: scelestial
doc: "A tool for single-cell lineage tree reconstruction (Note: The provided text
  contains error logs rather than help documentation, so specific arguments could
  not be extracted).\n\nTool homepage: https://github.com/hzi-bifo/scelestial-paper-materials-devel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scelestial:1.2--h9948957_4
stdout: scelestial.out
