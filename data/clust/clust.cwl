cwlVersion: v1.2
class: CommandLineTool
baseCommand: clust
label: clust
doc: "Optimised consensus clustering of multiple heterogeneous datasets\n\nTool homepage:
  https://github.com/baselabujamous/clust"
inputs:
  - id: datapath
    type: Directory
    doc: Data file path or directory with data file(s).
    inputBinding:
      position: 1
  - id: base_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more base clustering methods
    inputBinding:
      position: 102
      prefix: -basemethods
  - id: cluster_tightness
    type:
      - 'null'
      - float
    doc: Cluster tightness
    inputBinding:
      position: 102
      prefix: -t
  - id: deterministic
    type:
      - 'null'
      - boolean
    doc: Obsolete. All steps are already deterministic (v1.7.4+)
    inputBinding:
      position: 102
      prefix: --deterministic
  - id: filter_absolute
    type:
      - 'null'
      - boolean
    doc: Filter using absolute values of expression
    inputBinding:
      position: 102
      prefix: --fil-abs
  - id: filter_conditions
    type:
      - 'null'
      - int
    doc: 'Filtering: number of conditions'
    inputBinding:
      position: 102
      prefix: -fil-c
  - id: filter_datasets
    type:
      - 'null'
      - int
    doc: 'Filtering: number of datasets'
    inputBinding:
      position: 102
      prefix: -fil-d
  - id: filter_flat
    type:
      - 'null'
      - boolean
    doc: Filter out genes with flat expression profiles (default)
    inputBinding:
      position: 102
      prefix: --fil-flat
  - id: filter_percentile
    type:
      - 'null'
      - boolean
    doc: -fil-v is a percentile of genes rather than raw value
    inputBinding:
      position: 102
      prefix: --fil-perc
  - id: filter_value
    type:
      - 'null'
      - float
    doc: 'Filtering: gene expression threshold'
    inputBinding:
      position: 102
      prefix: -fil-v
  - id: k_values
    type:
      - 'null'
      - type: array
        items: int
    doc: K values, e.g. 2 4 6 10 ...
    inputBinding:
      position: 102
      prefix: -K
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: OrthoGroups (OGs) mapping file
    inputBinding:
      position: 102
      prefix: -m
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Smallest cluster size
    inputBinding:
      position: 102
      prefix: -cs
  - id: min_datasets
    type:
      - 'null'
      - int
    doc: Min datasets in which a gene must exist
    inputBinding:
      position: 102
      prefix: -d
  - id: no_filter_flat
    type:
      - 'null'
      - boolean
    doc: Cancels the default --fil-flat option
    inputBinding:
      position: 102
      prefix: --no-fil-flat
  - id: no_optimisation
    type:
      - 'null'
      - boolean
    doc: Skip cluster optimsation & completion
    inputBinding:
      position: 102
      prefix: --no-optimisation
  - id: normalization
    type:
      - 'null'
      - type: array
        items: string
    doc: Normalisation file or list of codes
    inputBinding:
      position: 102
      prefix: -n
  - id: outlier_std
    type:
      - 'null'
      - float
    doc: Outlier standard deviations
    inputBinding:
      position: 102
      prefix: -s
  - id: parallel_processes
    type:
      - 'null'
      - int
    doc: Obsolete. Number of parallel processes
    inputBinding:
      position: 102
      prefix: -np
  - id: q3s_outliers
    type:
      - 'null'
      - float
    doc: Q3s defining outliers
    inputBinding:
      position: 102
      prefix: -q3s
  - id: replicates_file
    type:
      - 'null'
      - File
    doc: Replicates structure file
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clust:1.18.0--pyh086e186_0
