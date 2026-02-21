cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral-ngs
label: viral-ngs
doc: "A collection of analysis pipelines for viral sequencing data.\n\nTool homepage:
  https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs.out
