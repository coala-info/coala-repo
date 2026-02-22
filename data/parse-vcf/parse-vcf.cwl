cwlVersion: v1.2
class: CommandLineTool
baseCommand: parse-vcf
label: parse-vcf
doc: "A tool for parsing VCF files (Note: The provided input text contains system
  error messages regarding disk space and container image conversion rather than the
  tool's help documentation. No arguments could be extracted.)\n\nTool homepage: https://github.com/david-a-parry/parse_vcf.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parse-vcf:0.2.8--pyhdfd78af_1
stdout: parse-vcf.out
