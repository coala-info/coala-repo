cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pispino
  - seqprep
label: pispino_pispino_seqprep
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/hsgweon/pispino"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pispino:1.1--py35_0
stdout: pispino_pispino_seqprep.out
