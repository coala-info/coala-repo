cwlVersion: v1.2
class: CommandLineTool
baseCommand: CanSNPer
label: cansnper_CanSNPer
doc: "A toolkit for SNP-typing using NGS data.\n\nTool homepage: https://github.com/adrlar/CanSNPer/"
inputs:
  - id: allow_differences
    type:
      - 'null'
      - int
    doc: allow a number of SNPs to be wrong, i.e.continue moving down the tree 
      even if none of the SNPs of the lower level are present
    default: 0
    inputBinding:
      position: 101
      prefix: --allow_differences
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: path to CanSNPerDB.db
    inputBinding:
      position: 101
      prefix: --db_path
  - id: delete_organism
    type:
      - 'null'
      - boolean
    doc: deletes all information in the database concerning an organism
    inputBinding:
      position: 101
      prefix: -delete_organism
  - id: dev
    type:
      - 'null'
      - boolean
    doc: dev mode
    inputBinding:
      position: 101
      prefix: --dev
  - id: draw_tree
    type:
      - 'null'
      - boolean
    doc: draw a pdf version of the tree, marking SNPs of the query sequence
    inputBinding:
      position: 101
      prefix: --draw_tree
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: argument used if Galaxy is running CanSNPer, do NOT use.
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: import_seq_file
    type:
      - 'null'
      - File
    doc: loads a sequence file into the database
    inputBinding:
      position: 101
      prefix: --import_seq_file
  - id: import_snp_file
    type:
      - 'null'
      - File
    doc: imports a list of SNPs into the database
    inputBinding:
      position: 101
      prefix: --import_snp_file
  - id: import_tree_file
    type:
      - 'null'
      - File
    doc: imports a tree structure into the database
    inputBinding:
      position: 101
      prefix: --import_tree_file
  - id: initialise_organism
    type:
      - 'null'
      - boolean
    doc: initialise a new table for an organism
    inputBinding:
      position: 101
      prefix: -initialise_organism
  - id: list_snps
    type:
      - 'null'
      - boolean
    doc: lists the SNPs of the given sequence
    inputBinding:
      position: 101
      prefix: --list_snps
  - id: num_threads
    type:
      - 'null'
      - int
    doc: maximum number of threads CanSNPer is allowed to use, the default [0] 
      is no limit, CanSNPer will start one process per reference genome while 
      aligning
    default: 0
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: progressive_mauve
    type:
      - 'null'
      - File
    doc: path to progressiveMauve binary file
    inputBinding:
      position: 101
      prefix: --progressiveMauve
  - id: query
    type:
      - 'null'
      - File
    doc: fasta sequence file name that is to be analysed
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type:
      - 'null'
      - string
    doc: the name of the organism
    inputBinding:
      position: 101
      prefix: --reference
  - id: save_align
    type:
      - 'null'
      - boolean
    doc: saves the alignment file
    inputBinding:
      position: 101
      prefix: --save_align
  - id: strain_name
    type:
      - 'null'
      - string
    doc: the name of the strain
    inputBinding:
      position: 101
      prefix: --strain_name
  - id: tab_sep
    type:
      - 'null'
      - boolean
    doc: print the results in a simple tab separated format
    inputBinding:
      position: 101
      prefix: --tab_sep
  - id: tmp_path
    type:
      - 'null'
      - Directory
    doc: where temporary files are stored
    inputBinding:
      position: 101
      prefix: --tmp_path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: prints some more information about the goings-ons of the program while 
      running
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper:1.0.10--py_1
stdout: cansnper_CanSNPer.out
