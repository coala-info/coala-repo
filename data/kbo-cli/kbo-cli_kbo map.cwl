cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kbo-cli
  - kbo
  - map
label: kbo-cli_kbo map
doc: "Map sequence data against a reference.\n\nTool homepage: https://docs.rs/kbo"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: Sequence data file(s).
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
  - id: input_list
    type: File
    doc: File with paths or tab separated name and path on each line.
    inputBinding:
      position: 102
      prefix: --input-list
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size, larger values are slower and use more space.
    inputBinding:
      position: 102
      prefix: -k
  - id: max_error_prob
    type:
      - 'null'
      - float
    doc: Tolerance for errors in k-mer matching.
    inputBinding:
      position: 102
      prefix: --max-error-prob
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: Memory available when building on temp disk space (in gigabytes).
    inputBinding:
      position: 102
      prefix: --mem-gb
  - id: no_gap_filling
    type:
      - 'null'
      - boolean
    doc: Skip running the gap filling algorithm.
    inputBinding:
      position: 102
      prefix: --no-gap-filling
  - id: no_variant_calling
    type:
      - 'null'
      - boolean
    doc: Skip using variant calling to improve the alignment.
    inputBinding:
      position: 102
      prefix: --no-variant-calling
  - id: prefix_precalc
    type:
      - 'null'
      - int
    doc: Length of precalculated prefixes included in the index.
    inputBinding:
      position: 102
      prefix: --prefix-precalc
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Output the internal representation instead of an alignment.
    inputBinding:
      position: 102
      prefix: --raw
  - id: reference
    type: File
    doc: Reference sequence to map against.
    inputBinding:
      position: 102
      prefix: --reference
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Build on temporary disk space at this path instead of in-memory.
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
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
