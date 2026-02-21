cwlVersion: v1.2
class: CommandLineTool
baseCommand: progenomes
label: progenomes
doc: "The provided text is a container build log and does not contain CLI help information
  or argument definitions.\n\nTool homepage: https://github.com/BigDataBiology/progenomes-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
stdout: progenomes.out
