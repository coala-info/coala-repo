cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfx
label: vcfx_VCFX_diff_tool
doc: "The provided text does not contain help information or usage instructions. It
  contains container runtime log messages and a fatal error encountered during an
  image build process.\n\nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_diff_tool.out
