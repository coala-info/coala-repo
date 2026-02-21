cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - VCFX_gl_filter
label: vcfx_VCFX_gl_filter
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/execution.\n\nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_gl_filter.out
