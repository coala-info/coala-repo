cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal plot
label: reveal_plot
doc: "Generate mumplot for two fasta files.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: fastas
    type:
      type: array
      items: File
    doc: Two fasta files for which a mumplot should be generated.
    inputBinding:
      position: 1
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Wheter to produce interactive plots which allow zooming on the dotplot
    default: false
    inputBinding:
      position: 102
      prefix: -i
  - id: maximal_unique_matches
    type:
      - 'null'
      - boolean
    doc: Plot only maximal unique matches.
    inputBinding:
      position: 102
      prefix: -u
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of exact matches to vizualize
    default: 100
    inputBinding:
      position: 102
      prefix: -m
  - id: region
    type:
      - 'null'
      - string
    doc: Highlight interval (as "<start>:<end>") with respect to x-axis (first 
      sequence).
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_plot.out
