cwlVersion: v1.2
class: CommandLineTool
baseCommand: syny_DIAMOND
label: syny_DIAMOND
doc: "The provided text does not contain help information for the tool; it contains
  Apptainer/Singularity container runtime logs and a fatal error message regarding
  an OCI image build failure.\n\nTool homepage: https://github.com/PombertLab/SYNY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syny:1.3.1--py312pl5321h7e72e81_0
stdout: syny_DIAMOND.out
