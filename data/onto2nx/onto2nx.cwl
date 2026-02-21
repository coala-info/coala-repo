cwlVersion: v1.2
class: CommandLineTool
baseCommand: onto2nx
label: onto2nx
doc: "A tool for converting ontologies to NetworkX graph objects. (Note: The provided
  text contains system error logs rather than help documentation; no arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/cthoyt/onto2nx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/onto2nx:0.1.1--py_0
stdout: onto2nx.out
