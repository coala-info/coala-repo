cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymummer_delta-filter
label: pymummer_delta-filter
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log.\n\nTool homepage: https://github.com/sanger-pathogens/pymummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer_delta-filter.out
