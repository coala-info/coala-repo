cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfast
label: dfast
doc: "DDBJ Fast Annotation and Submission Tool\n\nTool homepage: https://dfast.nig.ac.jp"
inputs:
  - id: additional_modifiers
    type:
      - 'null'
      - string
    doc: Additional modifiers for source features
    inputBinding:
      position: 101
      prefix: --additional_modifiers
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner to use
    default: ghostx
    inputBinding:
      position: 101
      prefix: --aligner
  - id: amr
    type:
      - 'null'
      - boolean
    doc: '[Preliminary implementation] Enable AMR/VFG annotation and identification
      of plasmid-derived contigs'
    inputBinding:
      position: 101
      prefix: --amr
  - id: complete
    type:
      - 'null'
      - boolean
    doc: Treat the query as a complete genome. Not required unless you need 
      INSDC submission files.
    inputBinding:
      position: 101
      prefix: --complete
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file (default config will be used if not specified)
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpu
  - id: database
    type:
      - 'null'
      - string
    doc: 'Additional reference database to be searched against prior to the default
      database. (format: db_path[,db_name[,pident,q_cov,s_cov,e_value]])'
    inputBinding:
      position: 101
      prefix: --database
  - id: dbroot
    type:
      - 'null'
      - Directory
    doc: DB root directory
    inputBinding:
      position: 101
      prefix: --dbroot
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode (Extra logging and retaining temporary files)
    inputBinding:
      position: 101
      prefix: --debug
  - id: fix_origin
    type:
      - 'null'
      - boolean
    doc: Rotate/flip the chromosome so that the dnaA gene comes first. (ONLY FOR
      A FINISHED GENOME)
    inputBinding:
      position: 101
      prefix: --fix_origin
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting output
    inputBinding:
      position: 101
      prefix: --force
  - id: gcode
    type:
      - 'null'
      - int
    doc: Genetic code
    default: 11
    inputBinding:
      position: 101
      prefix: --gcode
  - id: genome
    type: File
    doc: Genomic FASTA file for input. Can be gzipped.
    inputBinding:
      position: 101
      prefix: --genome
  - id: gff
    type:
      - 'null'
      - File
    doc: '[Preliminary implementation] Read GFF to import structural annotation. Ignores
      --use_original_name, --sort_sequence, --fix_origin.'
    inputBinding:
      position: 101
      prefix: --gff
  - id: locus_tag_prefix
    type:
      - 'null'
      - string
    doc: Locus tag prefix
    inputBinding:
      position: 101
      prefix: --locus_tag_prefix
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: Path to a metadata file (optional for DDBJ submission file)
    inputBinding:
      position: 101
      prefix: --metadata_file
  - id: metagenome
    type:
      - 'null'
      - boolean
    doc: Set options of MGA/Prodigal for metagenome contigs
    inputBinding:
      position: 101
      prefix: --metagenome
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length
    default: 200
    inputBinding:
      position: 101
      prefix: --minimum_length
  - id: no_cdd
    type:
      - 'null'
      - boolean
    doc: Disable CDDsearch
    inputBinding:
      position: 101
      prefix: --no_cdd
  - id: no_cds
    type:
      - 'null'
      - boolean
    doc: Disable CDS prediction
    inputBinding:
      position: 101
      prefix: --no_cds
  - id: no_crispr
    type:
      - 'null'
      - boolean
    doc: Disable CRISPR prediction
    inputBinding:
      position: 101
      prefix: --no_crispr
  - id: no_func_anno
    type:
      - 'null'
      - boolean
    doc: Disable all functional annotation steps
    inputBinding:
      position: 101
      prefix: --no_func_anno
  - id: no_hmm
    type:
      - 'null'
      - boolean
    doc: Disable HMMscan
    inputBinding:
      position: 101
      prefix: --no_hmm
  - id: no_rrna
    type:
      - 'null'
      - boolean
    doc: Disable rRNA prediction
    inputBinding:
      position: 101
      prefix: --no_rrna
  - id: no_trna
    type:
      - 'null'
      - boolean
    doc: Disable tRNA prediction
    inputBinding:
      position: 101
      prefix: --no_trna
  - id: offset
    type:
      - 'null'
      - int
    doc: Offset from the start codon of the dnaA gene. (for --fix_origin option)
    default: 0
    inputBinding:
      position: 101
      prefix: --offset
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism name
    inputBinding:
      position: 101
      prefix: --organism
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: OUT
    inputBinding:
      position: 101
      prefix: --out
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: Reference file(s) for OrthoSearch. Use semicolons for multiple files, 
      e.g. 'genome1.faa;genome2.gbk'
    inputBinding:
      position: 101
      prefix: --references
  - id: seq_names
    type:
      - 'null'
      - string
    doc: Sequence names for each sequence (for complete genome)
    inputBinding:
      position: 101
      prefix: --seq_names
  - id: seq_topologies
    type:
      - 'null'
      - string
    doc: Sequence topologies for each sequence (linear/circular, for complete 
      genome)
    inputBinding:
      position: 101
      prefix: --seq_topologies
  - id: seq_types
    type:
      - 'null'
      - string
    doc: Sequence types for each sequence (chromosome/plasmid, for complete 
      genome)
    inputBinding:
      position: 101
      prefix: --seq_types
  - id: show_config
    type:
      - 'null'
      - boolean
    doc: Show pipeline configuration and exit
    inputBinding:
      position: 101
      prefix: --show_config
  - id: sort_sequence
    type:
      - 'null'
      - boolean
    doc: Sort sequences by length
    inputBinding:
      position: 101
      prefix: --sort_sequence
  - id: step
    type:
      - 'null'
      - int
    doc: Increment step of locus tag
    default: 10
    inputBinding:
      position: 101
      prefix: --step
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain name
    inputBinding:
      position: 101
      prefix: --strain
  - id: threshold
    type:
      - 'null'
      - string
    doc: 'Thresholds for default database search (format: "pident,q_cov,s_cov,e_value")'
    default: 0,75,75,1e-6
    inputBinding:
      position: 101
      prefix: --threshold
  - id: use_genemarks2
    type:
      - 'null'
      - string
    doc: Use GeneMarkS2 to predict CDS instead of MGA.
    inputBinding:
      position: 101
      prefix: --use_genemarks2
  - id: use_locustag_as_gene_id
    type:
      - 'null'
      - boolean
    doc: Use locustag as gene ID for FASTA and GFF. (Useful when providing DFAST
      results to other tools such as Roary)
    inputBinding:
      position: 101
      prefix: --use_locustag_as_gene_id
  - id: use_original_name
    type:
      - 'null'
      - boolean
    doc: Use original sequence names in a query FASTA file
    inputBinding:
      position: 101
      prefix: --use_original_name
  - id: use_prodigal
    type:
      - 'null'
      - boolean
    doc: Use Prodigal to predict CDS instead of MGA
    inputBinding:
      position: 101
      prefix: --use_prodigal
  - id: use_rnammer
    type:
      - 'null'
      - string
    doc: Use RNAmmer to predict rRNA instead of Barrnap.
    inputBinding:
      position: 101
      prefix: --use_rnammer
  - id: use_separate_tags
    type:
      - 'null'
      - boolean
    doc: Use separate tags according to feature types
    inputBinding:
      position: 101
      prefix: --use_separate_tags
  - id: use_trnascan
    type:
      - 'null'
      - string
    doc: Use tRNAscan-SE to predict tRNA instead of Aragorn.
    inputBinding:
      position: 101
      prefix: --use_trnascan
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dfast:1.3.8--h5ca1c30_0
stdout: dfast.out
