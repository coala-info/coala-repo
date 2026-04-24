cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex_query2
label: kmindex_query2
doc: "To be used instead of kmindex query when many sub-indexes are registered, i.e.
  hundreds or thousands.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
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
