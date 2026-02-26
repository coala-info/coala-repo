cwlVersion: v1.2
class: CommandLineTool
baseCommand: olga-compute_pgen
label: olga_olga-compute_pgen
doc: "Compute Pgens for TCR and Ig sequences.\n\nTool homepage: https://github.com/zsethna/OLGA"
inputs:
  - id: alphabet_filename
    type:
      - 'null'
      - File
    doc: "specify PATH/TO/FILE defining a custom 'amino acid'\n                  \
      \      alphabet. Default is no custom alphabet."
    inputBinding:
      position: 101
      prefix: --alphabet_filename
  - id: comment_delimiter
    type:
      - 'null'
      - string
    doc: "character or string to indicate comment or header\n                    \
      \    lines to skip."
    inputBinding:
      position: 101
      prefix: --comment_delimiter
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "declare infile delimiter. Default is tab for .tsv\n                    \
      \    input files, comma for .csv files, and any whitespace\n               \
      \         for all others. Choices: 'tab', 'space',\n                       \
      \ ',', ';', ':'"
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: delimiter_out
    type:
      - 'null'
      - string
    doc: "declare outfile delimiter. Default is tab for .tsv\n                   \
      \     output files, comma for .csv files, and the infile\n                 \
      \       delimiter for all others. Choices: 'tab', 'space',\n               \
      \         ',', ';', ':'"
    inputBinding:
      position: 101
      prefix: --delimiter_out
  - id: display_off
    type:
      - 'null'
      - boolean
    doc: "turn the sequence display off (only applies in write-\n                \
      \        to-file mode). Default is on."
    default: on
    inputBinding:
      position: 101
      prefix: --display_off
  - id: gene_mask_delimiter
    type:
      - 'null'
      - string
    doc: "declare gene mask delimiter. Default comma unless\n                    \
      \    infile delimiter is comma, then default is a\n                        semicolon.
      Choices: 'tab', 'space', ',', ';', ':'"
    inputBinding:
      position: 101
      prefix: --gene_mask_delimiter
  - id: human_b_heavy
    type:
      - 'null'
      - boolean
    doc: use default human IGH model (B cell heavy chain)
    inputBinding:
      position: 101
      prefix: --human_B_heavy
  - id: human_b_kappa
    type:
      - 'null'
      - boolean
    doc: use default human IGK model (B cell light kappa chain)
    inputBinding:
      position: 101
      prefix: --human_B_kappa
  - id: human_b_lambda
    type:
      - 'null'
      - boolean
    doc: "use default human IGL model (B cell light lambda\n                     \
      \   chain)"
    inputBinding:
      position: 101
      prefix: --human_B_lambda
  - id: human_igh
    type:
      - 'null'
      - boolean
    doc: use default human IGH model (B cell heavy chain)
    inputBinding:
      position: 101
      prefix: --humanIGH
  - id: human_igk
    type:
      - 'null'
      - boolean
    doc: use default human IGK model (B cell light kappa chain)
    inputBinding:
      position: 101
      prefix: --humanIGK
  - id: human_igl
    type:
      - 'null'
      - boolean
    doc: "use default human IGL model (B cell light lambda\n                     \
      \   chain)"
    inputBinding:
      position: 101
      prefix: --humanIGL
  - id: human_t_alpha
    type:
      - 'null'
      - boolean
    doc: use default human TRA model (T cell alpha chain)
    inputBinding:
      position: 101
      prefix: --human_T_alpha
  - id: human_t_beta
    type:
      - 'null'
      - boolean
    doc: use default human TRB model (T cell beta chain)
    inputBinding:
      position: 101
      prefix: --human_T_beta
  - id: human_tra
    type:
      - 'null'
      - boolean
    doc: use default human TRA model (T cell alpha chain)
    inputBinding:
      position: 101
      prefix: --humanTRA
  - id: human_trb
    type:
      - 'null'
      - boolean
    doc: use default human TRB model (T cell beta chain)
    inputBinding:
      position: 101
      prefix: --humanTRB
  - id: infile
    type:
      - 'null'
      - File
    doc: "read in CDR3 sequences (and optionally V/J masks) from\n               \
      \         PATH/TO/FILE"
    inputBinding:
      position: 101
      prefix: --infile
  - id: j_in
    type:
      - 'null'
      - int
    doc: "specifies J_masks are found in column INDEX in the\n                   \
      \     input file. Default is no J mask."
    default: no J mask
    inputBinding:
      position: 101
      prefix: --j_in
  - id: j_mask
    type:
      - 'null'
      - string
    doc: "specify J usage to condition Pgen on for seqs read in\n                \
      \        as arguments."
    inputBinding:
      position: 101
      prefix: --j_mask
  - id: j_mask_index
    type:
      - 'null'
      - int
    doc: "specifies J_masks are found in column INDEX in the\n                   \
      \     input file. Default is no J mask."
    default: no J mask
    inputBinding:
      position: 101
      prefix: --j_mask_index
  - id: lines_to_skip
    type:
      - 'null'
      - int
    doc: skip the first N lines of the file. Default is 0.
    default: 0
    inputBinding:
      position: 101
      prefix: --lines_to_skip
  - id: max_number_of_seqs
    type:
      - 'null'
      - int
    doc: compute Pgens for at most N sequences.
    inputBinding:
      position: 101
      prefix: --max_number_of_seqs
  - id: mouse_b_heavy
    type:
      - 'null'
      - boolean
    doc: use default mouse IGH model (B cell heavy chain)
    inputBinding:
      position: 101
      prefix: --mouse_B_heavy
  - id: mouse_b_kappa
    type:
      - 'null'
      - boolean
    doc: use default mouse IGK model (B cell light kappa chain)
    inputBinding:
      position: 101
      prefix: --mouse_B_kappa
  - id: mouse_b_lambda
    type:
      - 'null'
      - boolean
    doc: "use default mouse IGL model (B cell light lambda\n                     \
      \   chain)"
    inputBinding:
      position: 101
      prefix: --mouse_B_lambda
  - id: mouse_igh
    type:
      - 'null'
      - boolean
    doc: use default mouse IGH model (B cell heavy chain)
    inputBinding:
      position: 101
      prefix: --mouseIGH
  - id: mouse_igk
    type:
      - 'null'
      - boolean
    doc: use default mouse IGK model (B cell light kappa chain)
    inputBinding:
      position: 101
      prefix: --mouseIGK
  - id: mouse_igl
    type:
      - 'null'
      - boolean
    doc: "use default mouse IGL model (B cell light lambda\n                     \
      \   chain)"
    inputBinding:
      position: 101
      prefix: --mouseIGL
  - id: mouse_t_alpha
    type:
      - 'null'
      - boolean
    doc: use default mouse TRA model (T cell alpha chain)
    inputBinding:
      position: 101
      prefix: --mouse_T_alpha
  - id: mouse_t_beta
    type:
      - 'null'
      - boolean
    doc: use default mouse TRB model (T cell beta chain)
    inputBinding:
      position: 101
      prefix: --mouse_T_beta
  - id: mouse_tra
    type:
      - 'null'
      - boolean
    doc: use default mouse TRA model (T cell alpha chain)
    inputBinding:
      position: 101
      prefix: --mouseTRA
  - id: mouse_trb
    type:
      - 'null'
      - boolean
    doc: use default mouse TRB model (T cell beta chain)
    inputBinding:
      position: 101
      prefix: --mouseTRB
  - id: num_lines_for_display
    type:
      - 'null'
      - int
    doc: "N lines of the output file are displayed when sequence\n               \
      \         display is on. Also used to determine the number of\n            \
      \            sequences to average over for speed and time\n                \
      \        estimates."
    inputBinding:
      position: 101
      prefix: --num_lines_for_display
  - id: raw_delimiter
    type:
      - 'null'
      - string
    doc: declare infile delimiter as a raw string.
    inputBinding:
      position: 101
      prefix: --raw_delimiter
  - id: raw_delimiter_out
    type:
      - 'null'
      - string
    doc: declare for the delimiter outfile as a raw string.
    inputBinding:
      position: 101
      prefix: --raw_delimiter_out
  - id: raw_gene_mask_delimiter
    type:
      - 'null'
      - string
    doc: declare delimiter of gene masks as a raw string.
    inputBinding:
      position: 101
      prefix: --raw_gene_mask_delimiter
  - id: seq_in
    type:
      - 'null'
      - int
    doc: "specifies sequences to be read in are in column INDEX.\n               \
      \         Default is index 0 (the first column)."
    default: 0
    inputBinding:
      position: 101
      prefix: --seq_in
  - id: seq_index
    type:
      - 'null'
      - int
    doc: "specifies sequences to be read in are in column INDEX.\n               \
      \         Default is index 0 (the first column)."
    default: 0
    inputBinding:
      position: 101
      prefix: --seq_index
  - id: seq_type_out
    type:
      - 'null'
      - string
    doc: "if read in sequences are ntseqs, declare what type of\n                \
      \        sequence to compute pgen for. Default is all. Choices:\n          \
      \              'all', 'ntseq', 'nucleotide', 'aaseq', 'amino_acid'"
    default: all
    inputBinding:
      position: 101
      prefix: --seq_type_out
  - id: seqs_per_time_update
    type:
      - 'null'
      - int
    doc: "specify the number of sequences between time updates.\n                \
      \        Default is 1e5."
    default: '1e5'
    inputBinding:
      position: 101
      prefix: --seqs_per_time_update
  - id: set_custom_model_vdj
    type:
      - 'null'
      - Directory
    doc: "specify PATH/TO/FOLDER/ for a custom VDJ generative\n                  \
      \      model"
    inputBinding:
      position: 101
      prefix: --set_custom_model_VDJ
  - id: set_custom_model_vj
    type:
      - 'null'
      - Directory
    doc: "specify PATH/TO/FOLDER/ for a custom VJ generative\n                   \
      \     model"
    inputBinding:
      position: 101
      prefix: --set_custom_model_VJ
  - id: skip_empty_off
    type:
      - 'null'
      - boolean
    doc: "stop skipping empty or blank sequences/lines (if for\n                 \
      \       example you want to keep line index fidelity between\n             \
      \           the infile and outfile)."
    inputBinding:
      position: 101
      prefix: --skip_empty_off
  - id: skip_fast_pgen
    type:
      - 'null'
      - boolean
    doc: "Skip the numba implementation to calculate Pgen, which\n               \
      \         is much faster."
    inputBinding:
      position: 101
      prefix: --skip_fast_pgen
  - id: skip_off
    type:
      - 'null'
      - boolean
    doc: "stop skipping empty or blank sequences/lines (if for\n                 \
      \       example you want to keep line index fidelity between\n             \
      \           the infile and outfile)."
    inputBinding:
      position: 101
      prefix: --skip_off
  - id: time_updates_off
    type:
      - 'null'
      - boolean
    doc: "turn time updates off (only applies when sequence\n                    \
      \    display is disabled)."
    inputBinding:
      position: 101
      prefix: --time_updates_off
  - id: v_in
    type:
      - 'null'
      - int
    doc: "specifies V_masks are found in column INDEX in the\n                   \
      \     input file. Default is no V mask."
    default: no V mask
    inputBinding:
      position: 101
      prefix: --v_in
  - id: v_mask
    type:
      - 'null'
      - string
    doc: "specify V usage to condition Pgen on for seqs read in\n                \
      \        as arguments."
    inputBinding:
      position: 101
      prefix: --v_mask
  - id: v_mask_index
    type:
      - 'null'
      - int
    doc: "specifies V_masks are found in column INDEX in the\n                   \
      \     input file. Default is no V mask."
    default: no V mask
    inputBinding:
      position: 101
      prefix: --v_mask_index
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write CDR3 sequences and pgens to PATH/TO/FILE
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
