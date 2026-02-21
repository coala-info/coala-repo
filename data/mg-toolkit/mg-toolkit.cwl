cwlVersion: v1.2
class: CommandLineTool
baseCommand: mg-toolkit
label: mg-toolkit
doc: "Metagenomics toolkit (Note: The provided text contains container runtime error
  logs rather than tool help text, so arguments could not be extracted).\n\nTool homepage:
  https://github.com/EBI-metagenomics/emg-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
stdout: mg-toolkit.out
