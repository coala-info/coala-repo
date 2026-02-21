cwlVersion: v1.2
class: CommandLineTool
baseCommand: altree
label: altree
doc: "Perform association tests and localization of susceptibility loci using phylogenetic
  trees.\n\nTool homepage: https://github.com/ALTree/bigfloat"
inputs:
  - id: anc_seq
    type:
      - 'null'
      - string
    doc: Specify the ancestral sequence (only useful with phylip and ancestral states
      file)
    inputBinding:
      position: 101
      prefix: --anc-seq
  - id: association
    type:
      - 'null'
      - boolean
    doc: Perform the association test
    inputBinding:
      position: 101
      prefix: --association
  - id: chi2_threshold
    type:
      - 'null'
      - float
    doc: Significance threshold for chi2
    default: 0.01
    inputBinding:
      position: 101
      prefix: --chi2-threshold
  - id: co_evo
    type:
      - 'null'
      - string
    doc: 'Type of co-evolution indice: simple (only anc -> der transition) or double
      (two possible transitions)'
    inputBinding:
      position: 101
      prefix: --co-evo
  - id: data_qual
    type:
      - 'null'
      - string
    doc: Analyse qualitative (case/control) or quantitative data
    inputBinding:
      position: 101
      prefix: --data-qual
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Type of data: DNA (ATGCU) or SNP (0-1)'
    inputBinding:
      position: 101
      prefix: --data-type
  - id: first_input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file 1 (paup, phylip or paml results file). If several input files
      are analysed, their names must be separated by colons.
    inputBinding:
      position: 101
      prefix: --first-input-file
  - id: nb_files
    type:
      - 'null'
      - int
    doc: Number of input files (1 and 2) to analyse (only for association test)
    inputBinding:
      position: 101
      prefix: --nb-files
  - id: no_prolongation
    type:
      - 'null'
      - boolean
    doc: No prolongation of branches in the tree
    inputBinding:
      position: 101
      prefix: --no-prolongation
  - id: number_of_trees_to_analyse
    type:
      - 'null'
      - int
    doc: Number of trees to analyse in the localisation analysis (only for localisation
      method using S-character)
    inputBinding:
      position: 101
      prefix: --number-of-trees-to-analyse
  - id: outgroup
    type:
      - 'null'
      - string
    doc: Root the tree with this outgroup
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: permutations
    type:
      - 'null'
      - int
    doc: Number of permutations used to calculate exact p_values (Only for association
      test)
    inputBinding:
      position: 101
      prefix: --permutations
  - id: print_tree
    type:
      - 'null'
      - boolean
    doc: If this option is selected, the tree will be printed to the output
    inputBinding:
      position: 101
      prefix: --print-tree
  - id: remove_outgroup
    type:
      - 'null'
      - boolean
    doc: Remove the outgroup of the tree before performing the tests
    inputBinding:
      position: 101
      prefix: --remove-outgroup
  - id: s_localisation
    type:
      - 'null'
      - boolean
    doc: Localise the susceptibility locus using the "S-character method"
    inputBinding:
      position: 101
      prefix: --s-localisation
  - id: s_site_characters
    type:
      - 'null'
      - string
    doc: 'Character states for the S character: ancestral state -> derived state ex:
      G->C or 0->1'
    inputBinding:
      position: 101
      prefix: --s-site-characters
  - id: s_site_number
    type:
      - 'null'
      - int
    doc: Number of the S character site in the sequence (only for localisation method
      using S-character)
    inputBinding:
      position: 101
      prefix: --s-site-number
  - id: second_input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file 2, containing the nb of cases/controls carrying an haplotype.
      Names must be separated by colons.
    default: correspond.txt
    inputBinding:
      position: 101
      prefix: --second-input-file
  - id: splitmode
    type:
      - 'null'
      - string
    doc: How tests are performed from a level to another (nosplit or chi2split)
    inputBinding:
      position: 101
      prefix: --splitmode
  - id: tree_building_program
    type:
      - 'null'
      - string
    doc: Phylogeny reconstruction program (phylip, paup, or paml)
    inputBinding:
      position: 101
      prefix: --tree-building-program
  - id: tree_to_analyse
    type:
      - 'null'
      - type: array
        items: int
    doc: Specify the tree to use (instead of random). Can be used several times to
      specify multiple trees.
    inputBinding:
      position: 101
      prefix: --tree-to-analyse
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/altree:v1.3.1-4b2-deb_cv1
