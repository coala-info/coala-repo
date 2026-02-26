cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphembed
  - validation
label: graphembed_validation
doc: "Graph/Network Embedding with Accuracy Benchmark\n\nTool homepage: https://github.com/jean-pierreBoth/graphembed"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., hope, sketching)
    inputBinding:
      position: 1
  - id: centric
    type:
      - 'null'
      - boolean
    doc: To ask for a centric validation pass after standard one, require no 
      value
    inputBinding:
      position: 102
      prefix: --centric
  - id: csvfile
    type: File
    doc: CSV file containing graph data
    inputBinding:
      position: 102
      prefix: --csv
  - id: nbpass
    type: int
    doc: number of passes of validation
    inputBinding:
      position: 102
      prefix: --nbpass
  - id: skip
    type: float
    doc: fraction of edges to skip in training set
    inputBinding:
      position: 102
      prefix: --skip
  - id: symetry
    type: string
    doc: Symmetry of the graph
    inputBinding:
      position: 102
      prefix: --symetric
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
stdout: graphembed_validation.out
