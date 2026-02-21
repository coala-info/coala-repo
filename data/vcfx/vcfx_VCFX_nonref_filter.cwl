cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - VCFX_nonref_filter
label: vcfx_VCFX_nonref_filter
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding image fetching.\n\nTool
  homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_nonref_filter.out
