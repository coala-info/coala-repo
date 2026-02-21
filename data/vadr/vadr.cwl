cwlVersion: v1.2
class: CommandLineTool
baseCommand: vadr
label: vadr
doc: "Viral Annotation DefineR (VADR) is a suite of tools for classifying and annotating
  virus sequences against a reference model. Note: The provided text contains system
  error logs rather than tool help documentation.\n\nTool homepage: https://github.com/ncbi/vadr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr.out
