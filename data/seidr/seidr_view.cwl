cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - view
label: seidr_view
doc: "View and filter contents of SeidrFiles\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Output binary SeidrFile
    inputBinding:
      position: 102
      prefix: --binary
  - id: case_insensitive
    type:
      - 'null'
      - boolean
    doc: Search case insensitive nodes
    inputBinding:
      position: 102
      prefix: --case-insensitive
  - id: centrality
    type:
      - 'null'
      - boolean
    doc: Print node centrality scores if present
    inputBinding:
      position: 102
      prefix: --centrality
  - id: column_headers
    type:
      - 'null'
      - boolean
    doc: Print column headers
    inputBinding:
      position: 102
      prefix: --column-headers
  - id: delim
    type:
      - 'null'
      - string
    doc: Delimiter for scores/ranks
    inputBinding:
      position: 102
      prefix: --delim
  - id: dense
    type:
      - 'null'
      - boolean
    doc: Print as much information as possible for each edge
    inputBinding:
      position: 102
      prefix: --dense
  - id: filter
    type:
      - 'null'
      - string
    doc: Supply a filter function to select edges
    inputBinding:
      position: 102
      prefix: --filter
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print file header as text
    inputBinding:
      position: 102
      prefix: --header
  - id: index
    type:
      - 'null'
      - string
    doc: Score column to use as edge weights
    inputBinding:
      position: 102
      prefix: --index
  - id: lines
    type:
      - 'null'
      - int
    doc: View only first l results
    inputBinding:
      position: 102
      prefix: --lines
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: Print node index instead of name
    inputBinding:
      position: 102
      prefix: --no-names
  - id: nodelist
    type:
      - 'null'
      - string
    doc: Include only these nodes
    inputBinding:
      position: 102
      prefix: --nodelist
  - id: sc_delim
    type:
      - 'null'
      - string
    doc: Delimiter for supplementary tags
    inputBinding:
      position: 102
      prefix: --sc-delim
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Fail on all issues instead of warning
    inputBinding:
      position: 102
      prefix: --strict
  - id: tags
    type:
      - 'null'
      - boolean
    doc: Print supplementary information tags
    inputBinding:
      position: 102
      prefix: --tags
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary data
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: threshold
    type:
      - 'null'
      - float
    doc: Only print edges with a weight >= t
    inputBinding:
      position: 102
      prefix: --threshold
  - id: threshold_rank
    type:
      - 'null'
      - boolean
    doc: Threshold edges with a rank of <= t instead
    inputBinding:
      position: 102
      prefix: --threshold-rank
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
