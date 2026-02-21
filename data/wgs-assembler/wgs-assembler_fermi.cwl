cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi
label: wgs-assembler_fermi
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/lh3/fermi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs-assembler:8.3--pl5.22.0_0
stdout: wgs-assembler_fermi.out
