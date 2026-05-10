cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex sum-query
label: kmindex_sum-query
doc: "Query a summarized index. (experimental)\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: fastx
    type: string
    doc: Input fasta/q file (supports gz/bzip2) containing the sequence(s) to 
      query.
    inputBinding:
      position: 101
      prefix: --fastx
  - id: global_index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --global-index
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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
