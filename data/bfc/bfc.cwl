cwlVersion: v1.2
class: CommandLineTool
baseCommand: bfc
label: bfc
doc: "The provided text does not contain help information for the tool 'bfc'. It contains
  system logs and error messages related to a failed container image build (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/Wilfred/bfc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bfc:r181--he4a0461_10
stdout: bfc.out
