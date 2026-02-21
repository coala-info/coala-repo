cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - sorter
label: vcfx_VCFX_sorter
doc: "A tool for sorting VCF files (Note: The provided text contains container build
  logs rather than command-line help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_sorter.out
