cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmicroclass
label: deepmicroclass
doc: "DeepMicroClass is a tool for classifying eukaryotic and prokaryotic viral and
  microbial sequences.\n\nTool homepage: https://github.com/chengsly/DeepMicroClass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
stdout: deepmicroclass.out
