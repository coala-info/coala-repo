cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasann
label: plasann
doc: "A tool for plasmid annotation (Note: The provided text is a container build
  error log and does not contain usage information or argument definitions).\n\nTool
  homepage: https://github.com/ajlopatkin/PlasAnn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasann:1.1.6--pyhdfd78af_0
stdout: plasann.out
