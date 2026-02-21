cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopack
label: nanopack
doc: "NanoPack is a suite of tools for visualizing and processing long-read sequencing
  data. (Note: The provided text is a system error message and does not contain CLI
  help information or argument definitions.)\n\nTool homepage: https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack.out
