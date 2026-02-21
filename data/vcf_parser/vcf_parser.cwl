cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf_parser
label: vcf_parser
doc: "A tool for parsing VCF (Variant Call Format) files. (Note: The provided text
  is a container engine error log and does not contain usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/moonso/vcf_parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf_parser:1.6--pyhdfd78af_0
stdout: vcf_parser.out
