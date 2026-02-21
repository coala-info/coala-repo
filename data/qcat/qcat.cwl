cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcat
label: qcat
doc: "A tool for demultiplexing Oxford Nanopore reads (Note: The provided text contains
  only system logs and error messages, not the actual help documentation for the tool).\n
  \nTool homepage: https://github.com/nanoporetech/qcat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcat:1.1.0--py_0
stdout: qcat.out
