cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusion-filter
label: fusion-filter
doc: "A tool for filtering gene fusions. (Note: The provided text contains system
  error logs regarding a container runtime failure and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/FusionFilter/FusionFilter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-filter:0.5.0--hdfd78af_4
stdout: fusion-filter.out
