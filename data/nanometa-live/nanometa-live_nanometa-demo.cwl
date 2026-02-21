cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanometa-live_nanometa-demo
label: nanometa-live_nanometa-demo
doc: "A tool from the nanometa-live suite (description unavailable due to execution
  error in provided text).\n\nTool homepage: https://github.com/FOI-Bioinformatics/nanometa_live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanometa-live:0.4.3--pyhdfd78af_0
stdout: nanometa-live_nanometa-demo.out
