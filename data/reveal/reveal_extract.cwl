cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal extract
label: reveal_extract
doc: "Extract the input sequence from a graph.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: graph
    type: File
    doc: gfa file specifying the graph from which the genome should be 
      extracted.
    inputBinding:
      position: 1
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the sample to be extracted from the graph.
    inputBinding:
      position: 2
  - id: width
    type:
      - 'null'
      - int
    doc: Line width for fasta output.
    inputBinding:
      position: 103
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_extract.out
