cwlVersion: v1.2
class: CommandLineTool
baseCommand: profile_dists
label: profile_dists
doc: "Calculate genetic distances based on allele profiles v. 1.0.10\n\nTool homepage:
  https://pypi.org/project/profile-dists"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Manual selection of how many records should be\n                       \
      \ included in a batch, default=auto"
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: columns
    type:
      - 'null'
      - string
    doc: "Single column file with one column name per line or\n                  \
      \      list of columns comma separate"
    inputBinding:
      position: 101
      prefix: --columns
  - id: count_missing
    type:
      - 'null'
      - boolean
    doc: Count missing as differences
    default: false
    inputBinding:
      position: 101
      prefix: --count_missing
  - id: cpus
    type:
      - 'null'
      - int
    doc: Count missing as differences
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: distm
    type:
      - 'null'
      - string
    doc: "Distance method raw hamming or scaled difference\n                     \
      \   [hamming, scaled]"
    default: scaled
    inputBinding:
      position: 101
      prefix: --distm
  - id: file_type
    type:
      - 'null'
      - string
    doc: Out format [text, parquet]
    default: text
    inputBinding:
      position: 101
      prefix: --file_type
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: json formatted allele mapping
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: match_threshold
    type:
      - 'null'
      - float
    doc: "Either a integer or float depending on what distance\n                 \
      \       method is used (only used with pairwise format"
    default: -1
    inputBinding:
      position: 101
      prefix: --match_threshold
  - id: max_mem
    type:
      - 'null'
      - string
    doc: Maximum amount of memory to use
    inputBinding:
      position: 101
      prefix: --max_mem
  - id: missing_thresh
    type:
      - 'null'
      - float
    doc: "Maximum percentage of missing data allowed per locus\n                 \
      \       (0 - 1)"
    default: 1.0
    inputBinding:
      position: 101
      prefix: --missing_thresh
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Out format [matrix, pairwise]
    default: matrix
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: query
    type: File
    doc: Query allelic profiles
    inputBinding:
      position: 101
      prefix: --query
  - id: ref
    type: File
    doc: Reference allelic profiles
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_qual_thresh
    type:
      - 'null'
      - float
    doc: "Maximum percentage of missing data allowed per sample\n                \
      \        (0 - 1)"
    default: 1.0
    inputBinding:
      position: 101
      prefix: --sample_qual_thresh
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Skip QA/QC steps
    default: false
    inputBinding:
      position: 101
      prefix: --skip
outputs:
  - id: outdir
    type: Directory
    doc: Result output files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/profile_dists:1.0.10--pyhdfd78af_0
