cwlVersion: v1.2
class: CommandLineTool
baseCommand: cassiopee
label: cassiopee
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process due to insufficient
  disk space.\n\nTool homepage: https://github.com/osallou/cassiopee-c"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cassiopee:v1.0.9-2-deb_cv1
stdout: cassiopee.out
