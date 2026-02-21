cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfexpress
label: vcfexpress
doc: "A tool for processing VCF files (Note: The provided text is a system error log
  and does not contain usage information or argument definitions).\n\nTool homepage:
  https://github.com/brentp/vcfexpress/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfexpress:0.3.4--h3ab6199_0
stdout: vcfexpress.out
