cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas-gene-annotation-manipulation
label: atlas-gene-annotation-manipulation
doc: "A tool for manipulating gene annotations, typically used in the context of Expression
  Atlas or similar bioinformatics pipelines.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-gene-annotation-manipulation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/atlas-gene-annotation-manipulation:1.1.1--hdfd78af_0
stdout: atlas-gene-annotation-manipulation.out
