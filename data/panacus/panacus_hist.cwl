cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panacus
  - hist
label: panacus_hist
doc: "Calculate coverage histogram\n\nTool homepage: https://github.com/marschall-lab/panacus"
inputs:
  - id: gfa_file
    type: File
    doc: graph in GFA1 format, accepts also compressed (.gz) file
    inputBinding:
      position: 1
  - id: count_type
    type:
      - 'null'
      - string
    doc: 'Graph quantity to be counted [default: node] [possible values: node, bp,
      edge, all]'
    inputBinding:
      position: 102
      prefix: --count
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: Exclude bp/node/edge in growth count that intersect with paths 
      (1-column list) or path coordinates (3- or 12-column BED-file) provided by
      the given file; all intersecting bp/node/edge will be exluded also in 
      other paths not part of the given list
    inputBinding:
      position: 102
      prefix: --exclude
  - id: groupby_file
    type:
      - 'null'
      - File
    doc: Merge counts from paths by path-group mapping from given tab-separated 
      two-column file
    inputBinding:
      position: 102
      prefix: --groupby
  - id: groupby_haplotype
    type:
      - 'null'
      - boolean
    doc: Merge counts from paths belonging to same haplotype
    inputBinding:
      position: 102
      prefix: --groupby-haplotype
  - id: groupby_sample
    type:
      - 'null'
      - boolean
    doc: Merge counts from paths belonging to same sample
    inputBinding:
      position: 102
      prefix: --groupby-sample
  - id: subset_file
    type:
      - 'null'
      - File
    doc: Produce counts by subsetting the graph to a given list of paths 
      (1-column list) or path coordinates (3- or 12-column BED file)
    inputBinding:
      position: 102
      prefix: --subset
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus_hist.out
