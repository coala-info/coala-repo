cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal_bubbles
label: reveal_bubbles
doc: "Extract all bubbles from the graph.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: graph
    type: File
    doc: Graph in gfa format from which bubbles are to be extracted.
    inputBinding:
      position: 1
  - id: reference
    type:
      - 'null'
      - string
    doc: Name of the sequence that, if possible, should be used as a coordinate 
      system or reference.
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_bubbles.out
