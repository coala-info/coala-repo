cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer
label: ribotricer
doc: "A tool for detecting actively translating ORFs from Ribo-seq data.\n\nTool homepage:
  https://github.com/smithlabcode/ribotricer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
stdout: ribotricer.out
