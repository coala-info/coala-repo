cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanometa-live
  - new
label: nanometa-live_nanometa-new
doc: "The provided text contains system error logs and container runtime information
  rather than the command-line help text for the tool. As a result, no arguments or
  descriptions could be extracted.\n\nTool homepage: https://github.com/FOI-Bioinformatics/nanometa_live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanometa-live:0.4.3--pyhdfd78af_0
stdout: nanometa-live_nanometa-new.out
