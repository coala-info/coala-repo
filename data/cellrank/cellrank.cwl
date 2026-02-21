cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellrank
label: cellrank
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cellrank'. It contains error logs related to a container image build failure
  (Apptainer/Singularity) due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/theislab/cellrank"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellrank:1.5.1--pyhdfd78af_0
stdout: cellrank.out
