cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_logitModel.py
label: cpat_make_logitModel
doc: "Build a logistic regression model using training data (coding and non-coding
  sequences) to be used by CPAT for coding potential assessment.\n\nTool homepage:
  https://cpat.readthedocs.io/en/latest/"
inputs:
  - id: coding_file
    type: File
    doc: Genomic sequences of protein-coding RNAs in FASTA or standard 12-column
      BED format (plain, .gz or .bz2). If this is a BED file, the reference 
      genome must be given.
    inputBinding:
      position: 101
      prefix: --cgene
  - id: noncoding_file
    type: File
    doc: Genomic sequences of non-coding RNAs in FASTA or standard 12-column BED
      format (plain, .gz or .bz2). If this is a BED file, the reference genome 
      must be given.
    inputBinding:
      position: 101
      prefix: --ngene
  - id: hexamer_dat
    type: File
    doc: Hexamer frequency table. Run 'make_hexamer_tab.py' to generate this 
      table.
    inputBinding:
      position: 101
      prefix: --hex
  - id: ref_genome
    type:
      - 'null'
      - File
    doc: Reference genome sequences in FASTA format. Ignore this option if mRNA
      sequences were provided. The genome is indexed automatically if the 
      .fai index does not exist.
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --ref
  - id: start_codons
    type:
      - 'null'
      - string
    doc: Start codon (use 'T' instead of 'U') used to define the start of open 
      reading frame (ORF). default=ATG
    inputBinding:
      position: 101
      prefix: --start
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: Stop codon (use 'T' instead of 'U') used to define the end of open 
      reading frame (ORF). Multiple stop codons are separated by ','. 
      default=TAG,TAA,TGA
    inputBinding:
      position: 101
      prefix: --stop
  - id: min_orf
    type:
      - 'null'
      - int
    doc: Minimum ORF length in nucleotides. default=30
    inputBinding:
      position: 101
      prefix: --min-orf
  - id: log_file
    type:
      - 'null'
      - string
    doc: Name of log file. default="make_logitModel_run_info.log"
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print detailed running information to screen.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_prefix
    type: string
    doc: The prefix of output files.
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: logit_model
    type: File
    doc: Output logit model (RData format).
    outputBinding:
      glob: $(inputs.out_prefix).logit.RData
  - id: feature_table
    type: File
    doc: Features (mRNA size, ORF size, Fickett score, hexamer score) of the 
      training sequences.
    outputBinding:
      glob: $(inputs.out_prefix).feature.xls
  - id: r_script
    type:
      - 'null'
      - File
    doc: R script used to build the model.
    outputBinding:
      glob: $(inputs.out_prefix).make_logitModel.r
  - id: log
    type:
      - 'null'
      - File
    doc: Run log file.
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'make_logitModel_run_info.log')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpat:3.0.5--py312hc9302aa_4
