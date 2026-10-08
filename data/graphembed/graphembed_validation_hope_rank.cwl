cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphembed
label: graphembed_validation_hope_rank
doc: "Graph/Network Embedding with Accuracy Benchmark (link prediction): Asymmetric Transitivity Preserving Graph Embedding (HOPE) with a target rank\n\nTool homepage: https://github.com/jean-pierreBoth/graphembed"
arguments:
  - position: 3
    valueFrom: validation
  - position: 5
    valueFrom: hope
  - position: 6
    valueFrom: rank
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
  - id: targetrank
    type: int
    doc: "rank expected"
    inputBinding:
      position: 10
      prefix: --targetrank
  - id: nbiter
    type: int
    doc: "integer between 2 and 5"
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
stdout: graphembed_validation_hope_rank.out
stderr: graphembed_validation_hope_rank.log
