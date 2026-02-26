cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk
label: datafunk_fasta
doc: "A collection of bioinformatics tools for sequence data manipulation and analysis.\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: subcommand
    type: string
    doc: "The subcommand to execute. Available subcommands include: 'repair_names',
      'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length',
      'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata',
      'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment',
      'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages',
      'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs',
      'AA_finder', 'bootstrap'."
    inputBinding:
      position: 1
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file for pad_alignment subcommand.
    inputBinding:
      position: 102
      prefix: --input.fasta
  - id: left_pad
    type:
      - 'null'
      - int
    doc: Amount to left-pad the alignment for pad_alignment subcommand.
    inputBinding:
      position: 102
      prefix: --left-pad
  - id: right_pad
    type:
      - 'null'
      - int
    doc: Amount to right-pad the alignment for pad_alignment subcommand.
    inputBinding:
      position: 102
      prefix: --right-pad
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout for pad_alignment subcommand.
    inputBinding:
      position: 102
      prefix: --stdout
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file for pad_alignment subcommand.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
