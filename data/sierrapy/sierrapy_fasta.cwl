cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sierrapy
  - fasta
label: sierrapy_fasta
doc: "Run alignment, drug resistance and other analysis for one or more FASTA-format
  files contained DNA sequences.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: One or more FASTA-format files containing DNA sequences.
    inputBinding:
      position: 1
  - id: no_sharding
    type:
      - 'null'
      - boolean
    doc: Save JSON result to a single file.
    inputBinding:
      position: 102
      prefix: --no-sharding
  - id: query_file
    type:
      - 'null'
      - File
    doc: A file contains GraphQL fragment definition on `SequenceAnalysis`.
    inputBinding:
      position: 102
      prefix: --query
  - id: sharding_integer
    type:
      - 'null'
      - int
    doc: Save JSON result files per n sequences.
    inputBinding:
      position: 102
      prefix: --sharding
  - id: skip_integer
    type:
      - 'null'
      - int
    doc: Skip first n sequences.
    inputBinding:
      position: 102
      prefix: --skip
  - id: step_integer
    type:
      - 'null'
      - int
    doc: Send batch requests per n sequences.
    inputBinding:
      position: 102
      prefix: --step
  - id: total_integer
    type:
      - 'null'
      - int
    doc: Total number of sequences; specify one to visualize a progress bar.
    inputBinding:
      position: 102
      prefix: --total
  - id: ugly
    type:
      - 'null'
      - boolean
    doc: Output compressed JSON result.
    inputBinding:
      position: 102
      prefix: --ugly
  - id: url
    type:
      - 'null'
      - string
    doc: URL of Sierra GraphQL Web Service.
    default: production URL varied by virus
    inputBinding:
      position: 102
      prefix: --url
  - id: virus
    type:
      - 'null'
      - string
    doc: Specify virus to be analyzed.
    default: HIV1
    inputBinding:
      position: 102
      prefix: --virus
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File path to store the JSON result.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
