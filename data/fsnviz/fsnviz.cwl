cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsnviz
label: fsnviz
doc: "Visualization of gene fusions (Note: The provided text is a container runtime
  error log and does not contain usage instructions or argument definitions).\n\n
  Tool homepage: https://github.com/bow/fsnviz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fsnviz:0.3.0--py35_1
stdout: fsnviz.out
