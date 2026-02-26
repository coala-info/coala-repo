cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - roc
label: seidr_roc
doc: "Calculate ROC curves of predictions in SeidrFiles given true edges\n\nTool homepage:
  https://github.com/bschiffthaler/seidr"
inputs:
  - id: network
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: all_scores
    type:
      - 'null'
      - boolean
    doc: Calculate ROC for all scores in the SeidrFile
    inputBinding:
      position: 102
      prefix: --all
  - id: edges
    type:
      - 'null'
      - int
    doc: Number of top edges to consider
    default: all
    inputBinding:
      position: 102
      prefix: --edges
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: fraction
    type:
      - 'null'
      - float
    doc: Fraction of gold standard edges to include
    default: all
    inputBinding:
      position: 102
      prefix: --fraction
  - id: gold_standard
    type: File
    doc: Gold standard (true edges) input file
    inputBinding:
      position: 102
      prefix: --gold
  - id: index
    type:
      - 'null'
      - string
    doc: Index of score to use
    default: last score
    inputBinding:
      position: 102
      prefix: --index
  - id: neg
    type:
      - 'null'
      - File
    doc: True negative edges
    inputBinding:
      position: 102
      prefix: --neg
  - id: points
    type:
      - 'null'
      - int
    doc: Number of data points to print
    default: all
    inputBinding:
      position: 102
      prefix: --points
  - id: tfs
    type:
      - 'null'
      - File
    doc: List of transcription factors to consider
    inputBinding:
      position: 102
      prefix: --tfs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads for parallel sorting
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
