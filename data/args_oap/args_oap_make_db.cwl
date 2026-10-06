cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - args_oap
  - make_db
label: args_oap_make_db
doc: "Create a database from a FASTA file (nucleotide or protein).\n\nTool homepage:
  https://github.com/xinehc/args_oap"
inputs:
  - id: infile
    type: File
    doc: Database FASTA file. Can be either nucleotide or protein.
    inputBinding:
      position: 101
      prefix: --infile
outputs:
  - id: database
    type: File
    doc: The input FASTA with its DIAMOND/BWA and BLAST indexes, written beside 
      it
    outputBinding:
      glob: $(inputs.infile.basename)
    secondaryFiles:
      - pattern: .dmnd
        required: false
      - pattern: .pdb
        required: false
      - pattern: .phr
        required: false
      - pattern: .pin
        required: false
      - pattern: .pjs
        required: false
      - pattern: .pot
        required: false
      - pattern: .psq
        required: false
      - pattern: .ptf
        required: false
      - pattern: .pto
        required: false
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
      - pattern: .ndb
        required: false
      - pattern: .nhr
        required: false
      - pattern: .nin
        required: false
      - pattern: .njs
        required: false
      - pattern: .not
        required: false
      - pattern: .nsq
        required: false
      - pattern: .ntf
        required: false
      - pattern: .nto
        required: false
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.infile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
stdout: args_oap_make_db.out
