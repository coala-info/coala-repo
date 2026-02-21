cwlVersion: v1.2
class: CommandLineTool
baseCommand: megalodon
label: megalodon
doc: "Megalodon is a tool for processing Oxford Nanopore data, though the provided
  text contains only system error logs and no usage information.\n\nTool homepage:
  https://github.com/nanoporetech/megalodon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megalodon:2.5.0--py311haab0aaa_4
stdout: megalodon.out
