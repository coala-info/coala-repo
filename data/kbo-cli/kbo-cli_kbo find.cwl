cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kbo-cli
  - kbo
  - find
label: kbo-cli_kbo find
doc: "Finds sequences in query files based on a reference or index.\n\nTool homepage:
  https://docs.rs/kbo"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: Query file(s) with sequence data.
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
  - id: detailed
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --detailed
  - id: index_prefix
    type:
      - 'null'
      - string
    doc: Prefix for prebuilt <prefix>.sbwt and <prefix>.lcs (excludes -r).
    inputBinding:
      position: 102
      prefix: --index
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
  - id: max_error_prob
    type:
      - 'null'
      - float
    doc: Tolerance for errors in k-mer matching.
    inputBinding:
      position: 102
      prefix: --max-error-prob
  - id: max_gap_len
    type:
      - 'null'
      - int
    doc: Allow gaps of this length in the alignment.
    inputBinding:
      position: 102
      prefix: --max-gap-len
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: Memory available when building on temp disk space (in gigabytes).
    inputBinding:
      position: 102
      prefix: --mem-gb
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length to report.
    inputBinding:
      position: 102
      prefix: --min-len
  - id: prefix_precalc
    type:
      - 'null'
      - int
    doc: Length of precalculated prefixes included in the index.
    inputBinding:
      position: 102
      prefix: --prefix-precalc
  - id: reference_file
    type:
      - 'null'
      - File
    doc: File with target sequence data (excludes -i).
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
