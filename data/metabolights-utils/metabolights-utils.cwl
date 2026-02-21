cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabolights-utils
label: metabolights-utils
doc: "MetaboLights utilities for data management and metadata handling.\n\nTool homepage:
  https://github.com/EBI-Metabolights/metabolights-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: metabolights-utils.out
