cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeplc
label: deeplc
doc: "DeepLC: Retention time prediction for proteomics\n\nTool homepage: http://compomics.github.io/projects/DeepLC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeplc:3.1.13--pyhdfd78af_0
stdout: deeplc.out
