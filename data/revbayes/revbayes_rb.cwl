cwlVersion: v1.2
class: CommandLineTool
baseCommand: rb
label: revbayes_rb
doc: "Bayesian phylogenetic inference using probabilistic graphical models and an
  interpreted language\n\nTool homepage: https://revbayes.github.io/"
inputs:
  - id: file
    type:
      - 'null'
      - string
    doc: Input file
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments
    inputBinding:
      position: 2
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Continue after error (with file or -e expr)
    inputBinding:
      position: 103
      prefix: --continue
  - id: expressions
    type:
      - 'null'
      - type: array
        items: string
    doc: Expression to evaluate
    inputBinding:
      position: 103
      prefix: --expression
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Force interactive (with file or -e expr)
    inputBinding:
      position: 103
      prefix: --interactive
  - id: jupyter
    type:
      - 'null'
      - boolean
    doc: Run in jupyter mode
    inputBinding:
      position: 103
      prefix: --jupyter
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Hide startup message (if no file or -e expr)
    inputBinding:
      position: 103
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed (unsigned integer)
    inputBinding:
      position: 103
      prefix: --seed
  - id: set_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Set an option key=value (See ?setOption for the list of available keys 
      and their associated values)
    inputBinding:
      position: 103
      prefix: --setOption
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revbayes:1.3.2--hf316886_0
stdout: revbayes_rb.out
