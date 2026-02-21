cwlVersion: v1.2
class: CommandLineTool
baseCommand: sctagger
label: sctagger
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/vpc-ccg/sctagger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
stdout: sctagger.out
