cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdrpcatch_scan
label: rdrpcatch_scan
doc: "Scan sequences for RdRps.\n\nTool homepage: https://github.com/dimitris-karapliafis/RdRpCATCH"
inputs:
  - id: alt_mmseqs_tax_db
    type:
      - 'null'
      - string
    doc: Optional alternative MMseqs2 seqTaxDB-formatted MMseqs2 database to 
      use. Can be a database name under 'mmseqs_dbs'or a path to a 
      seqTaxDB-formatted MMseqs2 database (path/to/base/filename). If omitted, 
      the default 'mmseqs_refseq_riboviria_20250211' is used.
    inputBinding:
      position: 101
      prefix: --alt-mmseqs-tax-db
  - id: bundle
    type:
      - 'null'
      - boolean
    doc: Bundle the output files into a single archive.
    default: false
    inputBinding:
      position: 101
      prefix: --bundle
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use for HMMsearch.
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: custom_dbs
    type:
      - 'null'
      - string
    doc: Comma-separated custom database names (already prepared in custom_dbs 
      dir under db-dir).
    inputBinding:
      position: 101
      prefix: --custom-dbs
  - id: db_dir
    type: Directory
    doc: Path to the directory containing RdRpCATCH databases.
    inputBinding:
      position: 101
      prefix: --db-dir
  - id: db_options
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of databases to search against. Valid options: RVMT,
      NeoRdRp, NeoRdRp.2.1, Olendraite_fam, Olendraite_gen, RDRP-scan, Lucaprot_HMM,
      Zayed_HMM, all, none.'
    inputBinding:
      position: 101
      prefix: --db-options
  - id: default_hmmsearch_params
    type:
      - 'null'
      - boolean
    doc: Use HMMER default hmmsearch thresholds (E=10.0, domE=10.0, incE=0.01, 
      incdomE=0.01, automatic Z). Overrides --evalue/--incevalue/--domev… and 
      ignores --zvalue.
    inputBinding:
      position: 101
      prefix: --default-hmmsearch-params
  - id: domevalue
    type:
      - 'null'
      - float
    doc: Domain E-value threshold for HMMsearch.
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --domevalue
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value threshold for HMMsearch.
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: Keep additional HMM score columns (norm_bitscore_profile, 
      norm_bitscore_sequence, ID_score) in the output.
    default: false
    inputBinding:
      position: 101
      prefix: --extended-output
  - id: gen_code
    type:
      - 'null'
      - int
    doc: 'Genetic code to use for translation. (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --gen-code
  - id: incdomevalue
    type:
      - 'null'
      - float
    doc: Inclusion domain E-value threshold for HMMsearch.
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --incdomevalue
  - id: incevalue
    type:
      - 'null'
      - float
    doc: Inclusion E-value threshold for HMMsearch.
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --incevalue
  - id: input
    type: File
    doc: Path to the input FASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files (Expert users)
    default: false
    inputBinding:
      position: 101
      prefix: --keep-tmp
  - id: length_thr
    type:
      - 'null'
      - int
    doc: 'Minimum length threshold for seqkit seq(default: 400). ONLY used for nucleotide
      sequences.'
    default: 400
    inputBinding:
      position: 101
      prefix: --length-thr
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing output directory.
    default: false
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: seq_type
    type:
      - 'null'
      - string
    doc: 'Type of sequence to search against: (prot,nuc). If omitted, type will be
      auto-detected.'
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zvalue
    type:
      - 'null'
      - int
    doc: Number of sequences to search against.
    default: 1000000
    inputBinding:
      position: 101
      prefix: --zvalue
outputs:
  - id: output
    type: Directory
    doc: Path to the output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdrpcatch:1.0.1.post1--pyhdfd78af_0
