cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgma-simple
label: pgma-simple
doc: The provided text does not contain help information for pgma-simple; it 
  consists of system error messages regarding disk space and container image 
  processing.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgma-simple:0.1--h9948957_7
stdout: pgma-simple.out
