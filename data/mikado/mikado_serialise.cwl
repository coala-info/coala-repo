cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - serialise
label: mikado_serialise
doc: "Serialise the ORFs, BLAST hits, junctions and external scores into the Mikado database.\n\nTool\
  \ homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: start_method
    type:
      - 'null'
      - string
    doc: 'Multiprocessing start method: fork, spawn or forkserver.'
    inputBinding:
      position: 101
      prefix: --start-method
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Use /dev/shm (if available) for faster database building.
    inputBinding:
      position: 101
      prefix: --shm
  - id: no_shm
    type:
      - 'null'
      - boolean
    doc: Force building the database on its final location.
    inputBinding:
      position: 101
      prefix: --no-shm
  - id: orfs
    type:
      - 'null'
      - type: array
        items: File
    doc: ORF BED file(s), joined with commas.
    inputBinding:
      position: 101
      prefix: --orfs
      itemSeparator: ','
  - id: transcripts
    type:
      - 'null'
      - type: array
        items: File
    doc: Transcript FASTA file(s) used for ORF calling and BLAST queries, joined with commas (same order
      as the ORF files).
    inputBinding:
      position: 101
      prefix: --transcripts
      itemSeparator: ','
  - id: max_regression
    type:
      - 'null'
      - string
    doc: Amount of sequence in the ORF (in %) to backtrack to find a valid START codon, if one is absent.
    inputBinding:
      position: 101
      prefix: -mr
  - id: codon_table
    type:
      - 'null'
      - string
    doc: 'Codon table to use. Default: 0.'
    inputBinding:
      position: 101
      prefix: --codon-table
  - id: no_start_adjustment
    type:
      - 'null'
      - boolean
    doc: Disable the start adjustment algorithm.
    inputBinding:
      position: 101
      prefix: -nsa
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of target sequences.
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: blast_targets
    type:
      - 'null'
      - type: array
        items: File
    doc: Target protein FASTA file(s), joined with commas.
    inputBinding:
      position: 101
      prefix: -bt
      itemSeparator: ','
  - id: xml
    type:
      - 'null'
      - type: array
        items: File
    doc: BLAST XML or tabular file(s) to parse, joined with commas.
    inputBinding:
      position: 101
      prefix: --xml
      itemSeparator: ','
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of threads to use for analysing the BLAST files.
    inputBinding:
      position: 101
      prefix: -p
  - id: single_thread
    type:
      - 'null'
      - boolean
    doc: Force serialise to run with a single thread.
    inputBinding:
      position: 101
      prefix: --single-thread
  - id: genome_fai
    type:
      - 'null'
      - File
    doc: Genome FASTA index.
    inputBinding:
      position: 101
      prefix: --genome_fai
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome FASTA file.
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    inputBinding:
      position: 101
      prefix: --genome
  - id: junctions
    type:
      - 'null'
      - File
    doc: Junctions BED file.
    inputBinding:
      position: 101
      prefix: --junctions
  - id: external_scores
    type:
      - 'null'
      - File
    doc: Tabular file containing external scores for the transcripts.
    inputBinding:
      position: 101
      prefix: --external-scores
  - id: max_objects
    type:
      - 'null'
      - int
    doc: 'Maximum number of objects to cache in memory before committing to the database. Default: 100,000.'
    inputBinding:
      position: 101
      prefix: -mo
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: Do not drop the contents of an existing Mikado DB before the serialisation.
    inputBinding:
      position: 101
      prefix: --no-force
  - id: force
    type:
      - 'null'
      - boolean
    doc: Delete or drop an existing database before the serialisation.
    inputBinding:
      position: 101
      prefix: --force
  - id: configuration
    type:
      - 'null'
      - File
    doc: Configuration file.
    inputBinding:
      position: 101
      prefix: --configuration
  - id: log
    type:
      - 'null'
      - string
    doc: 'Optional log file. Default: stderr.'
    inputBinding:
      position: 101
      prefix: -l
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory. Default: current working directory.'
    inputBinding:
      position: 101
      prefix: -od
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Log level: DEBUG, INFO, WARN or ERROR.'
    inputBinding:
      position: 101
      prefix: -lv
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet logging.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: blast_loading_debug
    type:
      - 'null'
      - boolean
    doc: Switch on the debug mode for the XML/TSV loading.
    inputBinding:
      position: 101
      prefix: --blast-loading-debug
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed number. Default: 0.'
    inputBinding:
      position: 101
      prefix: --seed
  - id: random_seed
    type:
      - 'null'
      - boolean
    doc: Generate a new random seed number.
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: db
    type:
      - 'null'
      - string
    doc: 'Output database. Default: derived from the configuration.'
    inputBinding:
      position: 201
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside the configuration or list file (annotations, genome, scoring file, ...); staged
      in the working directory so the relative names resolve.
outputs:
  - id: database
    type: File
    doc: Mikado SQLite database.
    outputBinding:
      glob: '$((inputs.output_dir ? inputs.output_dir + ''/'' : '''') + (inputs.db ? inputs.db : ''mikado.db''))'
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.staged_files ? inputs.staged_files : [])'
      - entry: '$(inputs.transcripts ? inputs.transcripts : [])'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
