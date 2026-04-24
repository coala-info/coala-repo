cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmindex
  - query
label: kmindex_query
doc: "Query index.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Aggregate results from batches into one file.
    inputBinding:
      position: 101
      prefix: --aggregate
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Size of query batches (0≈nb_seq/nb_thread).
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Keep more pages in cache (see doc for details).
    inputBinding:
      position: 101
      prefix: --fast
  - id: fastx
    type: string
    doc: Input fasta/q file (supports gz/bzip2) containing the sequence(s) to 
      query.
    inputBinding:
      position: 101
      prefix: --fastx
  - id: format
    type:
      - 'null'
      - string
    doc: Output format [json|matrix|json_vec|jsonl|jsonl_vec]
    inputBinding:
      position: 101
      prefix: --format
  - id: index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --index
  - id: names
    type:
      - 'null'
      - string
    doc: Sub-indexes to query, comma separated.
    inputBinding:
      position: 101
      prefix: --names
  - id: single_query
    type:
      - 'null'
      - string
    doc: Query identifier. All sequences are considered as a unique query.
    inputBinding:
      position: 101
      prefix: --single-query
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Shared k-mers threshold. in [0.0, 1.0]
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zvalue
    type:
      - 'null'
      - int
    doc: Index s-mers and query (s+z)-mers (findere algorithm).
    inputBinding:
      position: 101
      prefix: --zvalue
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
