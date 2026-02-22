cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-bpa-datamapper
label: atol-bpa-datamapper
doc: "A tool for BPA (Building the Phylogeny of Asterids) data mapping.\n\nTool homepage:
  https://github.com/TomHarrop/atol-bpa-datamapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-bpa-datamapper:0.2.0--pyhdfd78af_0
stdout: atol-bpa-datamapper.out
