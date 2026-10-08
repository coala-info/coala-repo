cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meryl
  - statistics
label: meryl_statistics
doc: "display total, unique, distinct, present number of the kmers on the screen. Accepts exactly one input meryl database.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: input_db
    type: Directory
    doc: "Input meryl database"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: stdout
    doc: "Text written to the screen by meryl statistics"
stdout: meryl_statistics_statistics.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
