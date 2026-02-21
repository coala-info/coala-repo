cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - VCFX_indel_normalizer
label: vcfx_VCFX_indel_normalizer
doc: "VCFX indel normalizer (Note: The provided help text contains only container
  build errors and no usage information.)\n\nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_indel_normalizer.out
