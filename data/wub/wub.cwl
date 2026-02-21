cwlVersion: v1.2
class: CommandLineTool
baseCommand: wub
label: wub
doc: "A tool for Nanopore data analysis and processing (Note: The provided text was
  a container build log and did not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/nanoporetech/wub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub.out
