cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seidr
  - cluster-enrichment
label: seidr_cluster-enrichment
doc: "Test whether clusters of two networks show significant overlap or extract clusters\n\
  \nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: first_mapping
    type: File
    doc: First cluster->gene mapping
    inputBinding:
      position: 1
  - id: second_mapping
    type:
      - 'null'
      - File
    doc: Another cluster->gene mapping
    inputBinding:
      position: 2
  - id: alpha
    type:
      - 'null'
      - float
    doc: Adjusted p-value cutoff
    default: SEIDR_COMPARE_CLUST_DEF_ALPHA
    inputBinding:
      position: 103
      prefix: --alpha
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Output delimiter
    default: ','
    inputBinding:
      position: 103
      prefix: --delim
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: max_members
    type:
      - 'null'
      - int
    doc: Maximum members of a cluster
    default: 200
    inputBinding:
      position: 103
      prefix: --max-members
  - id: min_members
    type:
      - 'null'
      - int
    doc: Minimum members of a cluster
    default: 20
    inputBinding:
      position: 103
      prefix: --min-members
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
