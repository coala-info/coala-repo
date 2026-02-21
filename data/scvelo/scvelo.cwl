cwlVersion: v1.2
class: CommandLineTool
baseCommand: scvelo
label: scvelo
doc: "The provided text does not contain help information or usage instructions for
  scvelo. It contains error logs related to a failed Singularity/Apptainer image build
  due to insufficient disk space.\n\nTool homepage: https://github.com/theislab/scvelo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvelo:0.2.5--pyhdfd78af_0
stdout: scvelo.out
