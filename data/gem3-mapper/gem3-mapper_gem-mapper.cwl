cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./gem-mapper
label: gem3-mapper_gem-mapper
doc: "GEM3 mapper\n\nTool homepage: https://github.com/smarco/gem3-mapper"
inputs:
  - id: alignment_global_min_identity
    type:
      - 'null'
      - string
    doc: Minimum global alignment identity (number or percentage)
    inputBinding:
      position: 101
      prefix: --alignment-global-min-identity
  - id: alignment_global_min_score
    type:
      - 'null'
      - string
    doc: Minimum global alignment score (number or percentage)
    inputBinding:
      position: 101
      prefix: --alignment-global-min-score
  - id: alignment_local
    type:
      - 'null'
      - string
    doc: "Local alignment strategy: 'never', 'if-unmapped'"
    inputBinding:
      position: 101
      prefix: --alignment-local
  - id: alignment_local_min_identity
    type:
      - 'null'
      - string
    doc: Minimum local alignment identity (number or percentage)
    inputBinding:
      position: 101
      prefix: --alignment-local-min-identity
  - id: alignment_local_min_score
    type:
      - 'null'
      - string
    doc: Minimum local alignment score (number or percentage)
    inputBinding:
      position: 101
      prefix: --alignment-local-min-score
  - id: alignment_max_error
    type:
      - 'null'
      - string
    doc: Maximum alignment error (number or percentage, default=0.12, 12%)
    inputBinding:
      position: 101
      prefix: --alignment-max-error
  - id: bisulfite_read
    type:
      - 'null'
      - string
    doc: "Bisulfite read type: 'inferred', '1', '2', 'interleaved', 'non-stranded'"
    inputBinding:
      position: 101
      prefix: --bisulfite-read
  - id: bzip_input
    type:
      - 'null'
      - boolean
    doc: Use bzip2 for input
    inputBinding:
      position: 101
      prefix: --bzip-input
  - id: bzip_output
    type:
      - 'null'
      - boolean
    doc: Bzip2 output
    inputBinding:
      position: 101
      prefix: --bzip-output
  - id: control_sequence
    type:
      - 'null'
      - string
    doc: Control sequence name
    inputBinding:
      position: 101
      prefix: --control_sequence
  - id: discordant_pair_search
    type:
      - 'null'
      - string
    doc: "Discordant pair search strategy: 'always', 'if-no-concordant', 'never'"
    inputBinding:
      position: 101
      prefix: --discordant-pair-search
  - id: gap_affine_penalties
    type:
      - 'null'
      - string
    doc: Gap affine penalties (A,B,O,X)
    inputBinding:
      position: 101
      prefix: --gap-affine-penalties
  - id: gzip_input
    type:
      - 'null'
      - boolean
    doc: Use gzip for input
    inputBinding:
      position: 101
      prefix: --gzip-input
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Gzip output
    inputBinding:
      position: 101
      prefix: --gzip-output
  - id: index_file
    type: File
    doc: GEM index file
    inputBinding:
      position: 101
      prefix: --index
  - id: input_end1
    type:
      - 'null'
      - File
    doc: Paired-end input, end-1
    inputBinding:
      position: 101
      prefix: --i1
  - id: input_end2
    type:
      - 'null'
      - File
    doc: Paired-end input, end-2
    inputBinding:
      position: 101
      prefix: --i2
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --input
  - id: mapping_mode
    type:
      - 'null'
      - string
    doc: "Mapping mode: 'fast', 'sensitive', or 'customed'"
    inputBinding:
      position: 101
      prefix: --mapping-mode
  - id: max_reported_matches
    type:
      - 'null'
      - string
    doc: Maximum reported matches (number or 'all')
    inputBinding:
      position: 101
      prefix: --max-reported-matches
  - id: max_template_length
    type:
      - 'null'
      - int
    doc: Maximum template length
    inputBinding:
      position: 101
      prefix: --max-template-length
  - id: min_template_length
    type:
      - 'null'
      - int
    doc: Minimum template length
    inputBinding:
      position: 101
      prefix: --min-template-length
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format: 'MAP' or 'SAM'"
    inputBinding:
      position: 101
      prefix: --output-format
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: overconversion_sequence
    type:
      - 'null'
      - string
    doc: Overconversion sequence name
    inputBinding:
      position: 101
      prefix: --overconversion_sequence
  - id: paired_end_alignment
    type:
      - 'null'
      - boolean
    doc: Enable paired-end alignment
    inputBinding:
      position: 101
      prefix: --paired-end-alignment
  - id: report_file
    type:
      - 'null'
      - File
    doc: Report file name
    inputBinding:
      position: 101
      prefix: --report-file
  - id: sam_compact
    type:
      - 'null'
      - boolean
    doc: Use compact SAM format ('true' or 'false')
    inputBinding:
      position: 101
      prefix: --sam-compact
  - id: sam_read_group_header
    type:
      - 'null'
      - string
    doc: Read group header string (e.g., '@RG\tID:xx\tSM:yy')
    inputBinding:
      position: 101
      prefix: --sam-read-group-header
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: underconversion_sequence
    type:
      - 'null'
      - string
    doc: Underconversion sequence name
    inputBinding:
      position: 101
      prefix: --underconversion_sequence
  - id: verbose
    type:
      - 'null'
      - string
    doc: "Verbosity level: 'quiet', 'user', 'dev'"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
stdout: gem3-mapper_gem-mapper.out
