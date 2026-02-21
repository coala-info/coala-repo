cwlVersion: v1.2
class: CommandLineTool
baseCommand: reparation_blast_reparation.pl
label: reparation_blast_reparation.pl
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding the image build process.\n
  \nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
stdout: reparation_blast_reparation.pl.out
