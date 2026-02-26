cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_tips
label: odgi_tips
doc: "Identifying break point positions relative to given query (reference) path(s)
  of all the tips in the graph or of tips of given path(s). Prints BED records to
  stdout.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: input_file
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --input
  - id: jaccard_context
    type:
      - 'null'
      - int
    doc: 'Maximum walking distance in nucleotides for one orientation when finding
      the best target (reference) range for each query path (default: 10000). Note:
      If we walked 9999 base pairs and **w, --jaccard-context** is **10000**, we will
      also include the next node, even if we overflow the actual limit.'
    default: 10000
    inputBinding:
      position: 101
      prefix: --jaccard-context
  - id: jaccards
    type:
      - 'null'
      - boolean
    doc: "If for a target (reference) path several matches are possible, also report
      the additional jaccard indices (default: false). In the resulting BED, an '.'
      is added, if set to 'false'."
    default: false
    inputBinding:
      position: 101
      prefix: --jaccards
  - id: n_best
    type:
      - 'null'
      - int
    doc: 'Report up to the Nth best target (reference) mapping for each query path
      (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --n-best
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: query_path
    type:
      - 'null'
      - string
    doc: Use this query path.
    inputBinding:
      position: 101
      prefix: --query-path
  - id: query_paths_file
    type:
      - 'null'
      - File
    doc: Use query paths listed (one per line) in FILE.
    inputBinding:
      position: 101
      prefix: --query-paths
  - id: step_index_file
    type:
      - 'null'
      - File
    doc: 'Load the step index from this *FILE*. The file name usually ends with *.stpidx*.
      (default: build the step index from scratch with a sampling rate of 8).'
    inputBinding:
      position: 101
      prefix: --step-index
  - id: target_path
    type:
      - 'null'
      - string
    doc: Use this target (reference) path.
    inputBinding:
      position: 101
      prefix: --target-path
  - id: target_paths_file
    type:
      - 'null'
      - File
    doc: Use target (reference) paths listed (one per line) in FILE.
    inputBinding:
      position: 101
      prefix: --target-paths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: not_visited_tsv_file
    type:
      - 'null'
      - File
    doc: Write target path(s) that do not visit the query path(s) to this FILE.
    outputBinding:
      glob: $(inputs.not_visited_tsv_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
