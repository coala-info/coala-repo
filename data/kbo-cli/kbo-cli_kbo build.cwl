cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kbo-cli
  - kbo
  - build
label: kbo-cli_kbo build
doc: "Build a k-mer index\n\nTool homepage: https://docs.rs/kbo"
inputs:
  - id: seq_files
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
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: Memory available when building on temp disk space (in gigabytes).
    default: 4
    inputBinding:
      position: 102
      prefix: --mem-gb
  - id: output_prefix
    type: string
    doc: Prefix for output files <prefix>.sbwt and <prefix>.lcs.
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: prefix_precalc
    type:
      - 'null'
      - int
    doc: Length of precalculated prefixes included in the index.
    default: 8
    inputBinding:
      position: 102
      prefix: --prefix-precalc
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
stdout: kbo-cli_kbo build.out
