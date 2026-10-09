cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-build
label: kraken_build
doc: "Build a Kraken database. Exactly one task option must be selected per call.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs:
  - id: db
    type: Directory
    doc: Kraken DB/library folder; it is copied into the working directory as kraken_db and returned updated
  - id: download_taxonomy
    type:
      - 'null'
      - boolean
    doc: Download NCBI taxonomic information
    inputBinding:
      position: 10
      prefix: --download-taxonomy
  - id: download_library
    type:
      - 'null'
      - string
    doc: Download partial library (archaea, bacteria, plasmid, viral or human)
    inputBinding:
      position: 10
      prefix: --download-library
  - id: add_to_library
    type:
      - 'null'
      - File
    doc: Add FILE to library
    inputBinding:
      position: 10
      prefix: --add-to-library
  - id: build
    type:
      - 'null'
      - boolean
    doc: Create DB from library (requires taxonomy and at least one file in library)
    inputBinding:
      position: 10
      prefix: --build
  - id: rebuild
    type:
      - 'null'
      - boolean
    doc: Create DB from library like --build, but remove existing non-library/taxonomy files before build
    inputBinding:
      position: 10
      prefix: --rebuild
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Remove unneeded files from a built database
    inputBinding:
      position: 10
      prefix: --clean
  - id: shrink
    type:
      - 'null'
      - int
    doc: Shrink an existing DB to have only NEW_CT k-mers
    inputBinding:
      position: 10
      prefix: --shrink
  - id: standard
    type:
      - 'null'
      - boolean
    doc: Download and create default database
    inputBinding:
      position: 10
      prefix: --standard
  - id: upgrade
    type:
      - 'null'
      - boolean
    doc: Upgrade an existing older database to use scrambled minimizer ordering
    inputBinding:
      position: 10
      prefix: --upgrade
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1)
    inputBinding:
      position: 20
      prefix: --threads
  - id: new_db
    type:
      - 'null'
      - string
    doc: New Kraken DB name (shrink task only; mandatory for shrink task)
    inputBinding:
      position: 21
      prefix: --new-db
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: K-mer length in bp (build/shrink tasks only; default 31)
    inputBinding:
      position: 22
      prefix: --kmer-len
  - id: minimizer_len
    type:
      - 'null'
      - int
    doc: Minimizer length in bp (build/shrink tasks only; default 15)
    inputBinding:
      position: 23
      prefix: --minimizer-len
  - id: jellyfish_hash_size
    type:
      - 'null'
      - string
    doc: Pass a specific hash size argument to jellyfish when building database (build task only)
    inputBinding:
      position: 24
      prefix: --jellyfish-hash-size
  - id: max_db_size
    type:
      - 'null'
      - float
    doc: Shrink the DB before full build, making sure database and index together use <= SIZE gigabytes (build task only)
    inputBinding:
      position: 25
      prefix: --max-db-size
  - id: shrink_block_offset
    type:
      - 'null'
      - int
    doc: When shrinking, select the k-mer that is NUM positions from the end of a block of k-mers (default 1)
    inputBinding:
      position: 26
      prefix: --shrink-block-offset
  - id: work_on_disk
    type:
      - 'null'
      - boolean
    doc: Perform most operations on disk rather than in RAM (will slow down build in most cases)
    inputBinding:
      position: 27
      prefix: --work-on-disk
arguments:
  - position: 1
    prefix: --db
    valueFrom: kraken_db
outputs:
  - id: db_out
    type: Directory
    doc: The updated Kraken DB folder
    outputBinding:
      glob: kraken_db
  - id: new_db_out
    type:
      - 'null'
      - Directory
    doc: The shrunk DB folder (shrink task)
    outputBinding:
      glob: $(inputs.new_db)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db)
        entryname: kraken_db
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_build.out
