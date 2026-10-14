cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsp.py
label: picrust2_hsp.py
doc: "This script performs hidden state prediction on tips in the input tree with unknown trait values. Typically this script is used to predict the copy number of gene families present in the predicted genome for each amplicon sequence variant, given a tree and a set of known trait values. This script outputs a table of trait predictions.\n\nTool homepage: https://github.com/picrust/picrust2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: tree
    type: File
    doc: 'The full reference tree in newick format containing both study sequences (i.e. ASVs or OTUs) and reference sequences.'
    inputBinding:
      position: 101
      prefix: --tree
  - id: in_trait
    type:
      - 'null'
      - string
    doc: 'Which default trait table to use: 16S, BIGG, CAZY, EC, GENE_NAMES, GO, KO, PFAM, COG, TIGRFAM or PHENO. Use observed_trait_table for a non-default table.'
    inputBinding:
      position: 101
      prefix: --in_trait
  - id: database
    type:
      - 'null'
      - string
    doc: 'Database used for the pathway calculations. Set this to oldIMG to run with the old IMG database.'
    inputBinding:
      position: 101
      prefix: -db
  - id: reference
    type:
      - 'null'
      - string
    doc: 'Which set of reference files to use (default: bac). Included options are bac/bacteria and arc/archaea.'
    inputBinding:
      position: 101
      prefix: --reference
  - id: observed_trait_table
    type:
      - 'null'
      - File
    doc: 'The input trait table describing directly observed traits (e.g. sequenced genomes) in tab-delimited format. Necessary if you want to use a custom table.'
    inputBinding:
      position: 101
      prefix: --observed_trait_table
  - id: edge_exponent
    type:
      - 'null'
      - float
    doc: 'Weighting of transition costs by the inverse length of edge lengths for maximum parsimony. If 0, edge lengths do not influence predictions (default: 0.5).'
    inputBinding:
      position: 101
      prefix: --edge_exponent
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Number of functions to run at a time on one processor (default: 500).'
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: hsp_method
    type:
      - 'null'
      - string
    doc: 'HSP method to use: mp, emp_prob, pic, scp or subtree_average (default: mp).'
    inputBinding:
      position: 101
      prefix: --hsp_method
  - id: calculate_NSTI
    type:
      - 'null'
      - boolean
    doc: 'Calculate NSTI and add to output file.'
    inputBinding:
      position: 101
      prefix: --calculate_NSTI
  - id: check
    type:
      - 'null'
      - boolean
    doc: 'Check input trait table before HSP.'
    inputBinding:
      position: 101
      prefix: --check
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to run in parallel (default: 1).'
    inputBinding:
      position: 101
      prefix: --processes
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Seed to make output reproducible, which is necessary for the emp_prob method (default: 100).'
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'If specified, print out wrapped commands and other details to screen.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: 'Output table with predicted abundances per study sequence in input tree. If the extension .gz is added the table will automatically be gzipped.'
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: 'Output table with predicted abundances per study sequence in input tree.'
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
