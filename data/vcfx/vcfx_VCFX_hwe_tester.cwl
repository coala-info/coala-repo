cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - VCFX_hwe_tester
label: vcfx_VCFX_hwe_tester
doc: "VCFX Hardy-Weinberg Equilibrium (HWE) tester. (Note: The provided help text
  contains only container execution logs and error messages, so no specific arguments
  could be extracted.)\n\nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_hwe_tester.out
