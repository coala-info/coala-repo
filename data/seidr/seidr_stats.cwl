cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - stats
label: seidr_stats
doc: "Calculate network centrality statistics\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: directed
    type:
      - 'null'
      - boolean
    doc: (Experimental) Use directionality information.
    inputBinding:
      position: 102
      prefix: --directed
  - id: eigenvector_tol
    type:
      - 'null'
      - float
    doc: Eigenvector centrality convergence tolerance
    inputBinding:
      position: 102
      prefix: --eigenvector-tol
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Calculate exact stats.
    inputBinding:
      position: 102
      prefix: --exact
  - id: index
    type:
      - 'null'
      - string
    doc: Index of score to use
    inputBinding:
      position: 102
      prefix: --index
  - id: metrics
    type:
      - 'null'
      - string
    doc: String describing metrics to calculate
    inputBinding:
      position: 102
      prefix: --metrics
  - id: nsamples
    type:
      - 'null'
      - int
    doc: Use N samples for approximations
    inputBinding:
      position: 102
      prefix: --nsamples
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory to store temporary data
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: weight_is_distance
    type:
      - 'null'
      - boolean
    doc: Edge weight represents a distance (rather than similarity).
    inputBinding:
      position: 102
      prefix: --weight-is-distance
  - id: weight_rank
    type:
      - 'null'
      - boolean
    doc: Set weight value to rank rather than score
    inputBinding:
      position: 102
      prefix: --weight-rank
outputs:
  - id: stats_file
    type: File
    doc: The input SeidrFile with the centrality statistics added (seidr stats modifies the file in place; view them with seidr view --centrality)
    outputBinding:
      glob: $(inputs.in_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
