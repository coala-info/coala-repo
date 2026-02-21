cwlVersion: v1.2
class: CommandLineTool
baseCommand: gifrop_pan_pipe
label: gifrop_pan_pipe
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system log messages and a fatal error indicating a failure to build
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/jtrachsel/gifrop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gifrop:0.0.9--hdfd78af_0
stdout: gifrop_pan_pipe.out
