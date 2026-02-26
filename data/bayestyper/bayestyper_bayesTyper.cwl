cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayestyper
label: bayestyper_bayesTyper
doc: "BayesTyper (v1.5 )\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: command
    type: string
    doc: Command to execute (cluster, genotype)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
stdout: bayestyper_bayesTyper.out
