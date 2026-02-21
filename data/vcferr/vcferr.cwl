cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcferr
label: vcferr
doc: "A tool for adding errors to VCF files (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation, so arguments could
  not be extracted).\n\nTool homepage: https://github.com/signaturescience/vcferr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcferr:1.0.2--pyh5e36f6f_0
stdout: vcferr.out
