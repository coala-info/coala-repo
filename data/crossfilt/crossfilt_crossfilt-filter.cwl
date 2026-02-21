cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossfilt-filter
label: crossfilt_crossfilt-filter
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run a container due to
  insufficient disk space.\n\nTool homepage: https://github.com/kennethabarr/CrossFilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt_crossfilt-filter.out
