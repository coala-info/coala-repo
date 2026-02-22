cwlVersion: v1.2
class: CommandLineTool
baseCommand: auriclass
label: auriclass
doc: "A tool for classification of A-to-I RNA editing sites (Note: Help text provided
  was an error log and contained no usage information).\n\nTool homepage: https://rivm-bioinformatics.github.io/auriclass/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/auriclass:0.5.4--pyhdfd78af_0
stdout: auriclass.out
