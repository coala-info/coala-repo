cwlVersion: v1.2
class: CommandLineTool
baseCommand: plannotate_yaml
label: plannotate_yaml
doc: "Annotates sequences with information from various databases.\n\nTool homepage:
  https://github.com/barricklab/pLannotate"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (e.g., FASTA).
    inputBinding:
      position: 1
  - id: fpbase_algo
    type:
      - 'null'
      - string
    doc: Algorithm for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-algo
  - id: fpbase_comp_based_stats
    type:
      - 'null'
      - int
    doc: Composition-based statistics for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-comp-based-stats
  - id: fpbase_compressed
    type:
      - 'null'
      - boolean
    doc: Whether fpbase database is compressed.
    inputBinding:
      position: 102
      prefix: --fpbase-compressed
  - id: fpbase_culling_overlap
    type:
      - 'null'
      - int
    doc: Culling overlap for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-culling-overlap
  - id: fpbase_default_type
    type:
      - 'null'
      - string
    doc: Default type for fpbase entries.
    inputBinding:
      position: 102
      prefix: --fpbase-default-type
  - id: fpbase_gapextend
    type:
      - 'null'
      - int
    doc: Gap extend penalty for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-gapextend
  - id: fpbase_gapopen
    type:
      - 'null'
      - int
    doc: Gap open penalty for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-gapopen
  - id: fpbase_id
    type:
      - 'null'
      - int
    doc: Identity threshold for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-id
  - id: fpbase_k
    type:
      - 'null'
      - int
    doc: k-value for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-k
  - id: fpbase_location
    type:
      - 'null'
      - string
    doc: Location of the fpbase database.
    inputBinding:
      position: 102
      prefix: --fpbase-location
  - id: fpbase_matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-matrix
  - id: fpbase_max_hsps
    type:
      - 'null'
      - int
    doc: Maximum number of HSPs for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-max-hsps
  - id: fpbase_method
    type:
      - 'null'
      - string
    doc: Method used for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-method
  - id: fpbase_min_orf
    type:
      - 'null'
      - int
    doc: Minimum ORF length for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-min-orf
  - id: fpbase_priority
    type:
      - 'null'
      - int
    doc: Priority of fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-priority
  - id: fpbase_seed_cut
    type:
      - 'null'
      - float
    doc: Seed cut-off for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-seed-cut
  - id: fpbase_threads
    type:
      - 'null'
      - int
    doc: Number of threads for fpbase annotation.
    inputBinding:
      position: 102
      prefix: --fpbase-threads
  - id: fpbase_version
    type:
      - 'null'
      - string
    doc: Version of the fpbase database.
    inputBinding:
      position: 102
      prefix: --fpbase-version
  - id: rfam_compressed
    type:
      - 'null'
      - boolean
    doc: Whether Rfam database is compressed.
    inputBinding:
      position: 102
      prefix: --rfam-compressed
  - id: rfam_default_type
    type:
      - 'null'
      - string
    doc: Default type for Rfam entries.
    inputBinding:
      position: 102
      prefix: --rfam-default-type
  - id: rfam_location
    type:
      - 'null'
      - string
    doc: Location of the Rfam database.
    inputBinding:
      position: 102
      prefix: --rfam-location
  - id: rfam_method
    type:
      - 'null'
      - string
    doc: Method used for Rfam annotation.
    inputBinding:
      position: 102
      prefix: --rfam-method
  - id: rfam_priority
    type:
      - 'null'
      - int
    doc: Priority of Rfam annotation.
    inputBinding:
      position: 102
      prefix: --rfam-priority
  - id: rfam_threads
    type:
      - 'null'
      - int
    doc: Number of threads for Rfam annotation.
    inputBinding:
      position: 102
      prefix: --rfam-threads
  - id: rfam_version
    type:
      - 'null'
      - string
    doc: Version of the Rfam database.
    inputBinding:
      position: 102
      prefix: --rfam-version
  - id: snapgene_compressed
    type:
      - 'null'
      - boolean
    doc: Whether snapgene database is compressed.
    inputBinding:
      position: 102
      prefix: --snapgene-compressed
  - id: snapgene_culling_limit
    type:
      - 'null'
      - int
    doc: Culling limit for snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-culling-limit
  - id: snapgene_default_type
    type:
      - 'null'
      - string
    doc: Default type for snapgene entries.
    inputBinding:
      position: 102
      prefix: --snapgene-default-type
  - id: snapgene_location
    type:
      - 'null'
      - string
    doc: Location of the snapgene database.
    inputBinding:
      position: 102
      prefix: --snapgene-location
  - id: snapgene_max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of target sequences for snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-max-target-seqs
  - id: snapgene_method
    type:
      - 'null'
      - string
    doc: Method used for snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-method
  - id: snapgene_num_threads
    type:
      - 'null'
      - int
    doc: Number of threads for snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-num-threads
  - id: snapgene_perc_identity
    type:
      - 'null'
      - float
    doc: Percent identity threshold for snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-perc-identity
  - id: snapgene_priority
    type:
      - 'null'
      - int
    doc: Priority of snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-priority
  - id: snapgene_version
    type:
      - 'null'
      - string
    doc: Version of the snapgene database.
    inputBinding:
      position: 102
      prefix: --snapgene-version
  - id: snapgene_word_size
    type:
      - 'null'
      - int
    doc: Word size for snapgene annotation.
    inputBinding:
      position: 102
      prefix: --snapgene-word-size
  - id: swissprot_algo
    type:
      - 'null'
      - string
    doc: Algorithm for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-algo
  - id: swissprot_comp_based_stats
    type:
      - 'null'
      - int
    doc: Composition-based statistics for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-comp-based-stats
  - id: swissprot_compressed
    type:
      - 'null'
      - boolean
    doc: Whether swissprot database is compressed.
    inputBinding:
      position: 102
      prefix: --swissprot-compressed
  - id: swissprot_culling_overlap
    type:
      - 'null'
      - int
    doc: Culling overlap for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-culling-overlap
  - id: swissprot_default_type
    type:
      - 'null'
      - string
    doc: Default type for swissprot entries.
    inputBinding:
      position: 102
      prefix: --swissprot-default-type
  - id: swissprot_gapextend
    type:
      - 'null'
      - int
    doc: Gap extend penalty for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-gapextend
  - id: swissprot_gapopen
    type:
      - 'null'
      - int
    doc: Gap open penalty for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-gapopen
  - id: swissprot_id
    type:
      - 'null'
      - int
    doc: Identity threshold for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-id
  - id: swissprot_k
    type:
      - 'null'
      - int
    doc: k-value for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-k
  - id: swissprot_location
    type:
      - 'null'
      - string
    doc: Location of the swissprot database.
    inputBinding:
      position: 102
      prefix: --swissprot-location
  - id: swissprot_matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-matrix
  - id: swissprot_max_hsps
    type:
      - 'null'
      - int
    doc: Maximum number of HSPs for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-max-hsps
  - id: swissprot_method
    type:
      - 'null'
      - string
    doc: Method used for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-method
  - id: swissprot_min_orf
    type:
      - 'null'
      - int
    doc: Minimum ORF length for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-min-orf
  - id: swissprot_priority
    type:
      - 'null'
      - int
    doc: Priority of swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-priority
  - id: swissprot_seed_cut
    type:
      - 'null'
      - float
    doc: Seed cut-off for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-seed-cut
  - id: swissprot_threads
    type:
      - 'null'
      - int
    doc: Number of threads for swissprot annotation.
    inputBinding:
      position: 102
      prefix: --swissprot-threads
  - id: swissprot_version
    type:
      - 'null'
      - string
    doc: Version of the swissprot database.
    inputBinding:
      position: 102
      prefix: --swissprot-version
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output annotation file (e.g., YAML).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
