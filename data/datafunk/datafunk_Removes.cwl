cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk
label: datafunk_Removes
doc: "A command-line tool with various subcommands for data manipulation and analysis.\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: subcommand
    type: string
    doc: "The subcommand to execute. Available subcommands: 'repair_names', 'remove_fasta',
      'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data',
      'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header',
      'add_epi_week', 'process_gisaid_data', 'pad_alignment', 'exclude_uk_seqs', 'get_CDS',
      'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column',
      'extract_unannotated_seqs', 'AA_finder', 'bootstrap'."
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
stdout: datafunk_Removes.out
