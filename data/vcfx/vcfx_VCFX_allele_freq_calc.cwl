cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - allele_freq_calc
label: vcfx_VCFX_allele_freq_calc
doc: "A tool for calculating allele frequencies from VCF files (Note: The provided
  help text contained system error messages and did not list specific arguments).\n
  \nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_allele_freq_calc.out
