cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgs-assembler
label: wgs-assembler
doc: "The provided text does not contain help information or usage instructions for
  wgs-assembler. It contains container runtime logs and a fatal error message regarding
  an image build failure.\n\nTool homepage: https://github.com/lh3/fermi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs-assembler:8.3--pl5.22.0_0
stdout: wgs-assembler.out
