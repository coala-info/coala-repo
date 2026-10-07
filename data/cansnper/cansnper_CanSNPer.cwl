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
    inputBinding:
      position: 101
      prefix: --allow_differences
  - id: db_path
    type:
      - 'null'
      - File
    doc: path to CanSNPerDB.db (SQLite file; staged writable so import options 
      can update it)
    inputBinding:
      position: 101
      prefix: --db_path
      valueFrom: $(self.basename)
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
    doc: fasta sequence file name that is to be analysed (staged in the working
      directory, because the SNP list and tree PDF are written beside it)
    inputBinding:
      position: 101
      prefix: --query
      valueFrom: $(self.basename)
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
      - string
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
  - id: snp_list
    type:
      - 'null'
      - File
    doc: SNP list written with --list_snps
    outputBinding:
      glob: '*_snplist.txt'
  - id: tree_pdf
    type:
      - 'null'
      - File
    doc: tree PDF written with --draw_tree
    outputBinding:
      glob: '*_tree.pdf'
  - id: alignments
    type:
      type: array
      items: File
    doc: alignment files saved with --save_align
    outputBinding:
      glob: '*.CanSNPer.*.fa'
  - id: database
    type:
      - 'null'
      - File
    doc: the (possibly updated) CanSNPer database
    outputBinding:
      glob: '$(inputs.db_path ? inputs.db_path.basename : [])'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: cansnper
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.query)
        writable: true
      - entry: $(inputs.db_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper:1.0.10--py_1
stdout: cansnper_CanSNPer.out
