cwlVersion: v1.2
class: CommandLineTool
baseCommand: slivar
label: slivar
doc: "A tool for filtering and manipulating VCF files (Note: The provided help text
  contains only container runtime error messages and no usage information).\n\nTool
  homepage: https://github.com/brentp/slivar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
stdout: slivar.out
