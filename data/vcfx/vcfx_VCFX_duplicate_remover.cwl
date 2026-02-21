cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - duplicate_remover
label: vcfx_VCFX_duplicate_remover
doc: "A tool to remove duplicate records from VCF files. (Note: The provided help
  text contains only container runtime error messages and does not list specific arguments.)\n
  \nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_duplicate_remover.out
