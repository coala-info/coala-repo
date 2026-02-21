cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasten_sample
label: fasten_fasten_sample
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_sample.out
