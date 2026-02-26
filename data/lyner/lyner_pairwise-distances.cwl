cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - pairwise-distances
label: lyner_pairwise-distances
doc: "Compute pairwise distances between samples.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input
    type: File
    doc: Input matrix file (e.g. TSV, CSV)
    inputBinding:
      position: 1
  - id: metric
    type:
      - 'null'
      - string
    doc: 'Distance metric to use. Options: euclidean, manhattan, cosine, correlation,
      hamming, jaccard. Default: euclidean.'
    default: euclidean
    inputBinding:
      position: 102
      prefix: --metric
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format. Options: square, condensed. Default: square.'
    default: square
    inputBinding:
      position: 102
      prefix: --output-format
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default: 1.'
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output distance matrix file (e.g. TSV, CSV). Default: stdout.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
