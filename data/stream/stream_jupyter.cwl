cwlVersion: v1.2
class: CommandLineTool
baseCommand: stream_jupyter
label: stream_jupyter
doc: "The provided text appears to be an error log from a container runtime (Apptainer/Singularity)
  rather than CLI help text. No usage information or arguments could be extracted
  from this input.\n\nTool homepage: https://github.com/pinellolab/stream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stream:1.1--pyhdfd78af_0
stdout: stream_jupyter.out
