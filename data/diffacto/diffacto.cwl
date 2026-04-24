cwlVersion: v1.2
class: CommandLineTool
baseCommand: diffacto
label: diffacto
doc: "Diffacto: Differential analysis of (phospho)proteomics data\n\nTool homepage:
  https://github.com/statisticalbiotechnology/diffacto"
inputs:
  - id: cutoff_weight
    type:
      - 'null'
      - float
    doc: "Peptides weighted lower than the cutoff will be\n                      \
      \  excluded"
    inputBinding:
      position: 101
      prefix: -cutoff_weight
  - id: farms_alpha
    type:
      - 'null'
      - float
    doc: Hyperparameter weight of prior probability
    inputBinding:
      position: 101
      prefix: -farms_alpha
  - id: farms_mu
    type:
      - 'null'
      - float
    doc: Hyperparameter mu
    inputBinding:
      position: 101
      prefix: -farms_mu
  - id: fast_em
    type:
      - 'null'
      - boolean
    doc: "Allow early termination in EM calculation when noise\n                 \
      \       is sufficiently small."
    inputBinding:
      position: 101
      prefix: -fast
  - id: impute_threshold
    type:
      - 'null'
      - float
    doc: "Minimum fraction of missing values in the group.\n                     \
      \   Impute missing values if missing fraction is larger\n                  \
      \      than the threshold."
    inputBinding:
      position: 101
      prefix: -impute_threshold
  - id: input_file
    type: File
    doc: "Peptides abundances in CSV format. The first row\n                     \
      \   should contain names for all samples. The first column\n               \
      \         should contain unique peptide sequences. Missing\n               \
      \         values should be empty instead of zeros."
    inputBinding:
      position: 101
      prefix: -i
  - id: log2_scale
    type:
      - 'null'
      - boolean
    doc: "Input abundances are in log scale (True) or linear\n                   \
      \     scale (False)"
    inputBinding:
      position: 101
      prefix: -log2
  - id: min_samples
    type:
      - 'null'
      - int
    doc: "Minimum number of samples peptides needed to be\n                      \
      \  quantified in"
    inputBinding:
      position: 101
      prefix: -min_samples
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Method for sample-wise normalization.
    inputBinding:
      position: 101
      prefix: -normalize
  - id: protein_database
    type:
      - 'null'
      - File
    doc: "Protein database in FASTA format. If None, the peptide\n               \
      \         file must have protein ID(s) in the second column."
    inputBinding:
      position: 101
      prefix: -db
  - id: reference_groups
    type:
      - 'null'
      - string
    doc: "Names of reference sample groups (separated by\n                       \
      \ semicolon)"
    inputBinding:
      position: 101
      prefix: -reference
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: "File of the sample list. One run and its sample group\n                \
      \        per line, separated by tab. If None, read from peptide\n          \
      \              file headings, then each run will be summarized as a\n      \
      \                  group."
    inputBinding:
      position: 101
      prefix: -samples
  - id: use_unique_peptides
    type:
      - 'null'
      - boolean
    doc: Use unique peptides only
    inputBinding:
      position: 101
      prefix: -use_unique
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output file (writing in TSV format).
    outputBinding:
      glob: $(inputs.output_file)
  - id: mc_output_file
    type:
      - 'null'
      - File
    doc: Path to MCFDR output (writing in TSV format).
    outputBinding:
      glob: $(inputs.mc_output_file)
  - id: loadings_output_file
    type:
      - 'null'
      - File
    doc: File for peptide loadings (writing in TSV format).
    outputBinding:
      glob: $(inputs.loadings_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffacto:1.0.7--pyh7cba7a3_0
