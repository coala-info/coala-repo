cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie
label: freddie
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a container runtime environment failure
  (no space left on device).\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie.out
