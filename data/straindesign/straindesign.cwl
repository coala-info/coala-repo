cwlVersion: v1.2
class: CommandLineTool
baseCommand: straindesign
label: straindesign
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container image build/fetch process.\n\nTool homepage: https://github.com/brsynth/straindesign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straindesign:3.2.3--pyhdfd78af_0
stdout: straindesign.out
