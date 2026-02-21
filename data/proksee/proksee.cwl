cwlVersion: v1.2
class: CommandLineTool
baseCommand: proksee
label: proksee
doc: "Proksee is a tool for genome assembly, annotation, and visualization.\n\nTool
  homepage: https://github.com/proksee-project/proksee-cmd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proksee:1.0.0a1--pyhdfd78af_0
stdout: proksee.out
