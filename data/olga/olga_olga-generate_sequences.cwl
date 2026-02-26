cwlVersion: v1.2
class: CommandLineTool
baseCommand: olga-generate_sequences
label: olga_olga-generate_sequences
doc: "Generates CDR3 sequences using VDJ generative models.\n\nTool homepage: https://github.com/zsethna/OLGA"
inputs:
  - id: conserved_j_residues
    type:
      - 'null'
      - string
    doc: specify conserved J residues. Default is 'FVW'.
    default: FVW
    inputBinding:
      position: 101
      prefix: --conserved_J_residues
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "declare delimiter choice. Default is tab for .tsv output files, comma for
      .csv files, and tab for all others. Choices: 'tab', 'space', ',', ';', ':'"
    inputBinding:
      position: 101
      prefix: --delimiter
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
    doc: use default human IGL model (B cell light lambda chain)
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
    doc: use default human IGL model (B cell light lambda chain)
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
    doc: use default mouse IGL model (B cell light lambda chain)
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
    doc: use default mouse IGL model (B cell light lambda chain)
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
  - id: num_seqs
    type:
      - 'null'
      - int
    doc: specify the number of sequences to generate.
    inputBinding:
      position: 101
      prefix: --num_seqs
  - id: raw_delimiter
    type:
      - 'null'
      - string
    doc: declare delimiter choice as a raw string.
    inputBinding:
      position: 101
      prefix: --raw_delimiter
  - id: record_genes_off
    type:
      - 'null'
      - boolean
    doc: turn off recording V and J gene info.
    inputBinding:
      position: 101
      prefix: --record_genes_off
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for pseudorandom number generator. Default is to not set a 
      seed.
    inputBinding:
      position: 101
      prefix: --seed
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "declare sequence type for output sequences. Choices: 'all' [default], 'ntseq',
      'nucleotide', 'aaseq', 'amino_acid'"
    default: all
    inputBinding:
      position: 101
      prefix: --seq_type
  - id: seqs_per_time_update
    type:
      - 'null'
      - int
    doc: specify the number of sequences between time updates. Default is 1e5
    default: '1e5'
    inputBinding:
      position: 101
      prefix: --seqs_per_time_update
  - id: set_custom_model_vdj
    type:
      - 'null'
      - Directory
    doc: specify PATH/TO/FOLDER/ for a custom VDJ generative model
    inputBinding:
      position: 101
      prefix: --set_custom_model_VDJ
  - id: set_custom_model_vj
    type:
      - 'null'
      - Directory
    doc: specify PATH/TO/FOLDER/ for a custom VJ generative model
    inputBinding:
      position: 101
      prefix: --set_custom_model_VJ
  - id: time_updates_off
    type:
      - 'null'
      - boolean
    doc: turn time updates off.
    inputBinding:
      position: 101
      prefix: --time_updates_off
  - id: vdj_model_folder
    type:
      - 'null'
      - Directory
    doc: specify PATH/TO/FOLDER/ for a custom VDJ generative model
    inputBinding:
      position: 101
      prefix: --VDJ_model_folder
  - id: vj_model_folder
    type:
      - 'null'
      - Directory
    doc: specify PATH/TO/FOLDER/ for a custom VJ generative model
    inputBinding:
      position: 101
      prefix: --VJ_model_folder
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write CDR3 sequences to PATH/TO/FILE
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
