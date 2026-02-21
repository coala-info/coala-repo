cwlVersion: v1.2
class: CommandLineTool
baseCommand: stream
label: stream
doc: "The provided text does not contain help information or a description for the
  tool 'stream'. It appears to be an error log from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/pinellolab/stream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stream:1.1--pyhdfd78af_0
stdout: stream.out
