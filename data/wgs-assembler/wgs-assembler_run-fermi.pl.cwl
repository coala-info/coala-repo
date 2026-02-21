cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgs-assembler_run-fermi.pl
label: wgs-assembler_run-fermi.pl
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error related to an Apptainer/Singularity
  image build failure.\n\nTool homepage: https://github.com/lh3/fermi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs-assembler:8.3--pl5.22.0_0
stdout: wgs-assembler_run-fermi.pl.out
