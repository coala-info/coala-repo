cwlVersion: v1.2
class: CommandLineTool
baseCommand: versionix
label: versionix
doc: "A tool to generate a JSON report of software versions used in a project or environment.\n
  \nTool homepage: https://github.com/sequana/versionix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/versionix:0.99.3--pyhdfd78af_0
stdout: versionix.out
