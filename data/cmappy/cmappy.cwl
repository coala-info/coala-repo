cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmappy
label: cmappy
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cmappy'. It contains error logs related to a failed container image build
  (Apptainer/Singularity) due to insufficient disk space.\n\nTool homepage: https://github.com/cmap/cmapPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmappy:4.0.1--py39h2de1943_8
stdout: cmappy.out
