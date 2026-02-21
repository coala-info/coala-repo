cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodesign
label: isodesign
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime error messages related to a lack of disk
  space during an image build.\n\nTool homepage: https://github.com/MetaboHUB-MetaToul-FluxoMet/IsoDesign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isodesign:2.0.3--pyhdfd78af_0
stdout: isodesign.out
