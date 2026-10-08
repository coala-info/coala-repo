cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphembed
label: graphembed_validation_sketching
doc: "Graph/Network Embedding with Accuracy Benchmark (link prediction): Highly-Efficient Graph/Network Embeddings via Recursive Sketching\n\nTool homepage: https://github.com/jean-pierreBoth/graphembed"
arguments:
  - position: 3
    valueFrom: validation
  - position: 5
    valueFrom: sketching
inputs:
  - id: csvfile
    type: File
    doc: "expecting a csv file (comma, tab or space separated edge list: from, to, optional weight)"
    inputBinding:
      position: 1
      prefix: --csv
  - id: symetric
    type: string
    doc: "symmetry of the graph: 'true' or 'false' (default true)"
    inputBinding:
      position: 2
      prefix: --symetric
  - id: nbpass
    type: int
    doc: "number of passes of validation"
    inputBinding:
      position: 4
      prefix: --nbpass
  - id: skip
    type: float
    doc: "fraction of edges to skip in training set"
    inputBinding:
      position: 4
      prefix: --skip
  - id: centric
    type:
      - 'null'
      - boolean
    doc: "To ask for a centric validation pass after standard one, require no value"
    inputBinding:
      position: 4
      prefix: --centric
  - id: dim
    type: int
    doc: "the embedding dimension"
    inputBinding:
      position: 10
      prefix: --dim
  - id: decay
    type: float
    doc: "decay coefficient"
    inputBinding:
      position: 10
      prefix: --decay
  - id: nbiter
    type: int
    doc: "number of loops around a node"
    inputBinding:
      position: 10
      prefix: --nbiter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Log messages (the tool logs to standard error; validation reports its AUC here)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: RUST_LOG
        envValue: info
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
stdout: graphembed_validation_sketching.out
stderr: graphembed_validation_sketching.log
