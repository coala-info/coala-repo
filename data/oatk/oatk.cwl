cwlVersion: v1.2
class: CommandLineTool
baseCommand: oatk
label: oatk
doc: "Organelle Assembly Tool Kit\n\nTool homepage: https://github.com/c-zhou/oatk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0
stdout: oatk.out
