cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kbo-cli
  - kbo
  - call
label: kbo-cli_kbo call
doc: "Call variants using k-mer based approach.\n\nTool homepage: https://docs.rs/kbo"
inputs:
  - id: query_file
    type: File
    doc: Query file with sequence data.
    inputBinding:
      position: 1
  - id: dedup_batches
    type:
      - 'null'
      - boolean
    doc: Deduplicate k-mer batches to save some memory.
    inputBinding:
      position: 102
      prefix: --dedup-batches
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size, larger values are slower and use more space.
    default: 51
    inputBinding:
      position: 102
      prefix: -k
  - id: max_error_prob
    type:
      - 'null'
      - float
    doc: Tolerance for errors in k-mer matching.
    default: 1e-08
    inputBinding:
      position: 102
      prefix: --max-error-prob
  - id: prefix_precalc
    type:
      - 'null'
      - int
    doc: Length of precalculated prefixes included in the index.
    default: 8
    inputBinding:
      position: 102
      prefix: --prefix-precalc
  - id: reference
    type: File
    doc: Reference sequence to call variants in.
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to a file instead of printing.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
