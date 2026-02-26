cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal comp
label: reveal_comp
doc: "Reverse complement the graph.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: graph
    type: File
    doc: The graph to be reverse complemented.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_comp.out
