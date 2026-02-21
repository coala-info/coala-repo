cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfx
label: vcfx_VCFX_concordance_checker
doc: "VCFX concordance checker (Note: The provided help text contains only container
  runtime logs and no usage information.)\n\nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_concordance_checker.out
