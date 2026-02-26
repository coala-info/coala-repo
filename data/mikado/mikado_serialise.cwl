cwlVersion: v1.2
class: CommandLineTool
baseCommand: mikado_serialise
label: mikado_serialise
doc: "Serialise Mikado database\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs:
  - id: output_db
    type:
      - 'null'
      - string
    doc: 'Optional output database. Default: derived from configuration'
    inputBinding:
      position: 1
  - id: blast_loading_debug
    type:
      - 'null'
      - boolean
    doc: Flag. If set, Mikado will switch on the debug mode for the XML/TSV 
      loading.
    inputBinding:
      position: 102
      prefix: --blast-loading-debug
  - id: blast_targets
    type:
      - 'null'
      - string
    doc: Target sequences
    inputBinding:
      position: 102
      prefix: --blast-targets
  - id: codon_table
    type:
      - 'null'
      - string
    doc: 'Codon table to use. Default: 0 (ie Standard, NCBI #1, but only ATG is considered
      a valid start codon.'
    inputBinding:
      position: 102
      prefix: --codon-table
  - id: configuration
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --configuration
  - id: external_scores
    type:
      - 'null'
      - File
    doc: Tabular file containing external scores for the transcripts. Each 
      column should have a distinct name, and transcripts have to be listed on 
      the first column.
    inputBinding:
      position: 102
      prefix: --external-scores
  - id: force
    type:
      - 'null'
      - boolean
    doc: Flag. If set, an existing databse will be deleted (sqlite) or dropped 
      (MySQL/PostGreSQL) before beginning the serialisation.
    inputBinding:
      position: 102
      prefix: --force
  - id: genome
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --genome
  - id: genome_fai
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --genome_fai
  - id: junctions
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --junctions
  - id: log
    type:
      - 'null'
      - File
    doc: 'Optional log file. Default: stderr'
    default: stderr
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Log level. Default: derived from the configuration; if absent, INFO'
    default: derived from the configuration; if absent, INFO
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_objects
    type:
      - 'null'
      - int
    doc: 'Maximum number of objects to cache in memory before committing to the database.
      Default: 100,000 i.e. approximately 450MB RAM usage for Drosophila.'
    default: 100,000
    inputBinding:
      position: 102
      prefix: --max-objects
  - id: max_regression
    type:
      - 'null'
      - string
    doc: '"Amount of sequence in the ORF (in %) to backtrack in order to find a valid
      START codon, if one is absent. Default: None'
    inputBinding:
      position: 102
      prefix: --max-regression
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of target sequences.
    inputBinding:
      position: 102
      prefix: --max-target-seqs
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: Flag. If set, do not drop the contents of an existing Mikado DB before 
      beginning the serialisation.
    inputBinding:
      position: 102
      prefix: --no-force
  - id: no_shm
    type:
      - 'null'
      - boolean
    doc: Force building the database on its final location, even if /dev/shm is 
      available.
    inputBinding:
      position: 102
      prefix: --no-shm
  - id: no_start_adjustment
    type:
      - 'null'
      - boolean
    doc: Disable the start adjustment algorithm. Useful when using e.g. 
      TransDecoder vs 5+.
    inputBinding:
      position: 102
      prefix: --no-start-adjustment
  - id: orfs
    type:
      - 'null'
      - type: array
        items: File
    doc: ORF BED file(s), separated by commas
    inputBinding:
      position: 102
      prefix: --orfs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory. Default: current working directory'
    default: current working directory
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of threads to use for analysing the BLAST files. This number 
      should not be higher than the total number of XML files.
    inputBinding:
      position: 102
      prefix: --procs
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - boolean
    doc: Generate a new random seed number (instead of the default of 0)
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed number. Default: 0.'
    default: 0
    inputBinding:
      position: 102
      prefix: --seed
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Use /dev/shm (if available) for faster database building.
    inputBinding:
      position: 102
      prefix: --shm
  - id: single_thread
    type:
      - 'null'
      - boolean
    doc: Force serialise to run with a single thread, irrespective of other 
      configuration options.
    inputBinding:
      position: 102
      prefix: --single-thread
  - id: start_method
    type:
      - 'null'
      - string
    doc: Multiprocessing start method.
    inputBinding:
      position: 102
      prefix: --start-method
  - id: transcripts
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Transcript FASTA file(s) used for ORF calling and BLAST queries, separated
      by commas. If multiple files are given, they must be in the same order of the
      ORF files. E.g. valid command lines are: --transcript_fasta all_seqs1.fasta
      --orfs all_orfs.bed --transcript_fasta seq1.fasta,seq2.fasta --orfs orfs1.bed,orf2.bed
      --transcript_fasta all_seqs.fasta --orfs orfs1.bed,orf2.bed These are invalid
      instead: # Inverted order --transcript_fasta seq1.fasta,seq2.fasta --orfs orfs2.bed,orf1.bed
      #Two transcript files, one ORF file --transcript_fasta seq1.fasta,seq2.fasta
      --orfs all_orfs.bed'
    inputBinding:
      position: 102
      prefix: --transcripts
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
  - id: xml
    type:
      - 'null'
      - type: array
        items: File
    doc: 'BLAST file(s) to parse. They can be provided in three ways: - a comma-separated
      list - as a base folder - using bash-like name expansion (*,?, etc.). In this
      case, you have to enclose the filename pattern in double quotes. Multiple folders/file
      patterns can be given, separated by a comma. BLAST files must be either of two
      formats: - BLAST XML - BLAST tabular format, with the following **custom** fields:
      qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue
      bitscore ppos btop'
    inputBinding:
      position: 102
      prefix: --xml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_serialise.out
