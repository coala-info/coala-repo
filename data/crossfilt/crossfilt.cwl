cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossfilt
label: crossfilt
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and a fatal error message related to a container
  build process (no space left on device).\n\nTool homepage: https://github.com/kennethabarr/CrossFilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt.out
