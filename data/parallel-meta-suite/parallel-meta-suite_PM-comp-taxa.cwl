cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-comp-taxa
label: parallel-meta-suite_PM-comp-taxa
doc: "Compute the Meta-Storms similarity/distance among samples\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: ref_database
    type:
      - 'null'
      - string
    doc: "Reference database (the help gives 'Empty database' as the default text)"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: sample_pair
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Two samples path for single sample comparison"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: list_file
    type:
      - 'null'
      - File
    doc: "Input files list for multi-sample comparison"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: list_path_prefix
    type:
      - 'null'
      - string
    doc: "List file path prefix [Optional for -l]"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: list_members
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Files named in the list; staged in the working directory so that the names in the list resolve"
  - id: otu_count_table
    type:
      - 'null'
      - File
    doc: "Input OTU count table (*.OTU.Count) for multi-sample comparison"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file, default is to output on screen"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: output_distance
    type:
      - 'null'
      - string
    doc: "Output format, distance (T) or similarity (F), default is T"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: print_heatmap
    type:
      - 'null'
      - string
    doc: "Print heatmap and clusters, T(rue) or F(alse), default is F"
    inputBinding:
      position: 1
      prefix: "-P"
  - id: distance_metric
    type:
      - 'null'
      - int
    doc: "Distance Metric, 0: Meta-Storms; 1: Meta-Storms-unweighted; 2: Cosine; 3: Euclidean; 4: Jensen-Shannon; 5: Bray-Curtis, default is 0"
    inputBinding:
      position: 1
      prefix: "-M"
  - id: copy_number_correction
    type:
      - 'null'
      - string
    doc: "rRNA copy number correction, T(rue) or F(alse), default is T"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: cluster_number
    type:
      - 'null'
      - int
    doc: "Cluster number, default is 2 [Optional for -P]"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default is auto"
    inputBinding:
      position: 1
      prefix: "-t"
outputs:
  - id: output_matrix
    type:
      - 'null'
      - File
    doc: "Distance or similarity matrix (only with -o)"
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: extra_outputs
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Heatmap and cluster files (only with -P T)"
    outputBinding:
      glob: "$(inputs.output_file ? inputs.output_file + '.*' : '*.pdf')"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.list_members ? inputs.list_members : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-comp-taxa.out
