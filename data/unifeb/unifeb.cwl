cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unifeb
label: unifeb
doc: "UniFrac Embedding via Approxiamte Nearest Neighbor Graph (default mode, no
  subcommand).\n\nTool homepage: https://github.com/jianshu93/unifeb.git"
inputs:
  - id: tree
    type: File
    doc: Newick tree filename
    inputBinding:
      position: 1
      prefix: --tree
  - id: feature_table
    type: File
    doc: Feature table with rows=features, columns=samples
    inputBinding:
      position: 2
      prefix: --feature-table
  - id: weighted
    type: ['null', boolean]
    doc: Use Weighted UniFrac (otherwise unweighted)
    inputBinding:
      position: 3
      prefix: --weighted
  - id: out
    type: ['null', string]
    default: embedded.csv
    doc: Output CSV file for embedded results
    inputBinding:
      position: 4
      prefix: --out
  - id: batch
    type: ['null', int]
    doc: Number of gradient batches (default 20)
    inputBinding:
      position: 5
      prefix: --batch
  - id: nbsample
    type: ['null', int]
    doc: Number of edge samplings per batch (default 10)
    inputBinding:
      position: 6
      prefix: --nbsample
  - id: layer
    type: ['null', int]
    doc: If >0, use hierarchical approach in embedding (default 0)
    inputBinding:
      position: 7
      prefix: --layer
  - id: scale
    type: ['null', float]
    doc: Rho scale factor for the gradient descent (default 1.0)
    inputBinding:
      position: 8
      prefix: --scale
  - id: dim
    type: ['null', int]
    doc: Dimension of embedding (default 2)
    inputBinding:
      position: 9
      prefix: --dim
  - id: quality
    type: ['null', float]
    doc: Sampling fraction for quality estimation, <=1.0
    inputBinding:
      position: 10
      prefix: --quality
outputs:
  - id: embedded
    type: File
    doc: Embedded coordinates (CSV)
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Log output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifeb:0.1.1--h3ab6199_0
stdout: unifeb.out
