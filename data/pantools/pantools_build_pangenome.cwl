cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - build_pangenome
label: pantools_build_pangenome
doc: "Build a pangenome from a set of genomes. Required software: KMC 3.1.0 or higher.\n\
  \nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_name
    type: string
    doc: Path to the database root directory (created by the tool).
    inputBinding:
      position: 1
  - id: genomes_file
    type: File
    doc: A text file containing paths to FASTA files of genomes; each in a separate
      line.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome FASTA files named in the genomes file. They are staged in the working
      directory, so the genomes file can name them by file name.
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel working threads, default is the number of cores or 8,
      whichever is lower.
    inputBinding:
      position: 102
      prefix: --threads=
      separate: false
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers. Should be in range [6..255]. By not giving this argument,
      the most optimal k-mer size is calculated automatically.
    inputBinding:
      position: 102
      prefix: --kmer-size=
      separate: false
  - id: scratch_directory
    type:
      - 'null'
      - string
    doc: Temporary directory for storing localization update files.
    inputBinding:
      position: 102
      prefix: --scratch-directory=
      separate: false
  - id: num_buckets
    type:
      - 'null'
      - int
    doc: 'Number of buckets for sorting (default: 200).'
    inputBinding:
      position: 102
      prefix: --num-buckets=
      separate: false
  - id: transaction_size
    type:
      - 'null'
      - int
    doc: 'Number of localization updates to pack into a single Neo4j transaction (default:
      10000).'
    inputBinding:
      position: 102
      prefix: --transaction-size=
      separate: false
  - id: num_db_writer_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for writing to Neo4j (default: 2).'
    inputBinding:
      position: 102
      prefix: --num-db-writer-threads=
      separate: false
  - id: cache_size
    type:
      - 'null'
      - int
    doc: 'Maximum number of items in the node properties cache (default: 10000000).'
    inputBinding:
      position: 102
      prefix: --cache-size=
      separate: false
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Do not delete intermediate localization files after the command finishes.
    inputBinding:
      position: 102
      prefix: --keep-intermediate-files
outputs:
  - id: database
    type: Directory
    doc: The new pangenome database
    outputBinding:
      glob: $(inputs.database_name)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomes_file)
        writable: true
      - $(inputs.genome_fasta_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_build_pangenome.log
