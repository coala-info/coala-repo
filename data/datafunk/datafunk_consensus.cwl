cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - consensus
label: datafunk_consensus
doc: "Subcommand for datafunk, specifically 'consensus'. The available subcommands
  for datafunk are: 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta',
  'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta',
  'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week',
  'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad
  <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root',
  'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs',
  'AA_finder', 'bootstrap'.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --input.fasta
  - id: left_pad
    type:
      - 'null'
      - int
    doc: Left padding value for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --left-pad
  - id: right_pad
    type:
      - 'null'
      - int
    doc: Right padding value for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --right-pad
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --stdout
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file for pad_alignment subcommand
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
