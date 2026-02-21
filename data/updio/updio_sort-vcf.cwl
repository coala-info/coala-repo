cwlVersion: v1.2
class: CommandLineTool
baseCommand: updio_sort-vcf
label: updio_sort-vcf
doc: "Sort VCF files (Note: The provided text contains container build/execution logs
  rather than tool help documentation, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/rhpvorderman/updio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/updio:1.1.0--hdfd78af_0
stdout: updio_sort-vcf.out
