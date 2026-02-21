cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgs-assembler_make
label: wgs-assembler_make
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Apptainer/Singularity) error logs regarding a failed image build.\n
  \nTool homepage: https://github.com/lh3/fermi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs-assembler:8.3--pl5.22.0_0
stdout: wgs-assembler_make.out
