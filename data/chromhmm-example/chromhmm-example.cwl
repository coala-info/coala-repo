cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromhmm-example
label: chromhmm-example
doc: "The provided text is a system error log indicating a failure to build or run
  the container image (no space left on device) and does not contain help documentation
  or argument definitions.\n\nTool homepage: https://github.com/jernst98/ChromHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/chromhmm-example:v1.18dfsg-1-deb_cv1
stdout: chromhmm-example.out
