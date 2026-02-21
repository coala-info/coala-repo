cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfx
label: vcfx_VCFX_fasta_converter
doc: "A tool for VCF and FASTA conversion (Note: The provided help text contains only
  container runtime error logs and does not list specific arguments).\n\nTool homepage:
  https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_fasta_converter.out
