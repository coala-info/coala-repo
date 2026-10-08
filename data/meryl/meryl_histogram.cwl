cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meryl
  - histogram
label: meryl_histogram
doc: "display kmer frequency on the screen as 'frequency<tab>count'. Accepts exactly one input meryl database.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: input_db
    type: Directory
    doc: "Input meryl database"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: stdout
    doc: "Text written to the screen by meryl histogram"
stdout: meryl_histogram_histogram.tsv
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
