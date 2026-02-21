cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - allele_counter
label: vcfx_VCFX_allele_counter
doc: "VCFX allele counter tool. (Note: The provided help text contains only container
  build logs and does not list specific command-line arguments or usage instructions.)\n
  \nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_allele_counter.out
