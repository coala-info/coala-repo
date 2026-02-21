cwlVersion: v1.2
class: CommandLineTool
baseCommand: resistify_download_models
label: resistify_download_models
doc: "Download models for resistify\n\nTool homepage: https://github.com/swiftseal/resistify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/resistify:1.3.0--pyhdfd78af_0
stdout: resistify_download_models.out
