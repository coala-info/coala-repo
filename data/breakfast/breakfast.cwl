cwlVersion: v1.2
class: CommandLineTool
baseCommand: breakfast
label: breakfast
doc: "Options:\n\nTool homepage: https://github.com/rki-mf1/breakfast"
inputs:
  - id: clust_col
    type:
      - 'null'
      - string
    doc: Metadata column to cluster
    inputBinding:
      position: 101
      prefix: --clust-col
  - id: id_col
    type:
      - 'null'
      - string
    doc: Column with the sequence identifier
    inputBinding:
      position: 101
      prefix: --id-col
  - id: input_cache
    type:
      - 'null'
      - File
    doc: Input cached pickle file from previous run
    inputBinding:
      position: 101
      prefix: --input-cache
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input-file
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to run simultaneously
    inputBinding:
      position: 101
      prefix: --jobs
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximum parwise distance
    inputBinding:
      position: 101
      prefix: --max-dist
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum cluster size
    inputBinding:
      position: 101
      prefix: --min-cluster-size
  - id: no_skip_del
    type:
      - 'null'
      - boolean
    doc: Skip deletions
    inputBinding:
      position: 101
      prefix: --no-skip-del
  - id: no_skip_ins
    type:
      - 'null'
      - boolean
    doc: Skip insertions
    inputBinding:
      position: 101
      prefix: --no-skip-ins
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory for all output files
    inputBinding:
      position: 101
      prefix: --outdir
  - id: reference_length
    type:
      - 'null'
      - int
    doc: Length of reference genome (defaults to NC_045512.2 length)
    inputBinding:
      position: 101
      prefix: --reference-length
  - id: sep
    type:
      - 'null'
      - string
    doc: Input file separator
    inputBinding:
      position: 101
      prefix: --sep
  - id: sep2
    type:
      - 'null'
      - string
    doc: Secondary clustering column separator (between each mutation)
    inputBinding:
      position: 101
      prefix: --sep2
  - id: skip_del
    type:
      - 'null'
      - boolean
    doc: Skip deletions
    inputBinding:
      position: 101
      prefix: --skip-del
  - id: skip_ins
    type:
      - 'null'
      - boolean
    doc: Skip insertions
    inputBinding:
      position: 101
      prefix: --skip-ins
  - id: trim_end
    type:
      - 'null'
      - int
    doc: Bases to trim from the end (0 = disable)
    inputBinding:
      position: 101
      prefix: --trim-end
  - id: trim_start
    type:
      - 'null'
      - int
    doc: Bases to trim from the beginning (0 = disable)
    inputBinding:
      position: 101
      prefix: --trim-start
  - id: var_type
    type:
      - 'null'
      - string
    doc: Type of variants
    inputBinding:
      position: 101
      prefix: --var-type
outputs:
  - id: output_cache
    type:
      - 'null'
      - File
    doc: Path to Output cached pickle file
    outputBinding:
      glob: $(inputs.output_cache)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakfast:0.4.6--pyhdfd78af_0
