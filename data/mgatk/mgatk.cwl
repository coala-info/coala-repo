cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgatk
label: mgatk
doc: "Mitochondrial Genome Analysis ToolKit\n\nTool homepage: https://github.com/caleblareau/mgatk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
stdout: mgatk.out
