cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken2-build
label: kraken2_build
doc: "Build a Kraken 2 database. Exactly one task option must be selected per call.\n\nTool homepage: https://github.com/DerrickWood/kraken2"
inputs:
  - id: db
    type: Directory
    doc: Kraken 2 DB/library folder; it is copied into the working directory as kraken_db and returned updated
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
    doc: Download partial library (archaea, bacteria, plasmid, viral, human, fungi, plant, protozoa, nr, nt, UniVec or UniVec_Core)
    inputBinding:
      position: 10
      prefix: --download-library
  - id: special
    type:
      - 'null'
      - string
    doc: Download and build a special database (greengenes, silva or rdp)
    inputBinding:
      position: 10
      prefix: --special
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
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Remove unneeded files from a built database
    inputBinding:
      position: 10
      prefix: --clean
  - id: standard
    type:
      - 'null'
      - boolean
    doc: Download and build default database
    inputBinding:
      position: 10
      prefix: --standard
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1)
    inputBinding:
      position: 20
      prefix: --threads
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: K-mer length in bp/aa (build task only; default 35 nt, 15 aa)
    inputBinding:
      position: 21
      prefix: --kmer-len
  - id: minimizer_len
    type:
      - 'null'
      - int
    doc: Minimizer length in bp/aa (build task only; default 31 nt, 12 aa)
    inputBinding:
      position: 22
      prefix: --minimizer-len
  - id: minimizer_spaces
    type:
      - 'null'
      - int
    doc: Number of characters in minimizer that are ignored in comparisons (build task only; default 7 nt, 0 aa)
    inputBinding:
      position: 23
      prefix: --minimizer-spaces
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Build a protein database for translated search
    inputBinding:
      position: 24
      prefix: --protein
  - id: no_masking
    type:
      - 'null'
      - boolean
    doc: Avoid masking low-complexity sequences before building (masking needs dustmasker or segmasker)
    inputBinding:
      position: 25
      prefix: --no-masking
  - id: max_db_size
    type:
      - 'null'
      - long
    doc: Maximum number of bytes for the Kraken 2 hash table; the library is downsampled to fit (used with --build, --standard, --special)
    inputBinding:
      position: 26
      prefix: --max-db-size
  - id: use_ftp
    type:
      - 'null'
      - boolean
    doc: Use FTP for downloading instead of RSYNC
    inputBinding:
      position: 27
      prefix: --use-ftp
  - id: skip_maps
    type:
      - 'null'
      - boolean
    doc: Avoid downloading accession number to taxid maps (used with --download-taxonomy)
    inputBinding:
      position: 28
      prefix: --skip-maps
  - id: load_factor
    type:
      - 'null'
      - float
    doc: Proportion of the hash table to be populated (build task only; default 0.7)
    inputBinding:
      position: 29
      prefix: --load-factor
  - id: fast_build
    type:
      - 'null'
      - boolean
    doc: Do not require the database to be deterministically built with multiple threads (faster)
    inputBinding:
      position: 30
      prefix: --fast-build
arguments:
  - position: 1
    prefix: --db
    valueFrom: kraken_db
outputs:
  - id: db_out
    type: Directory
    doc: The updated Kraken 2 DB folder
    outputBinding:
      glob: kraken_db
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
    dockerPull: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
stdout: kraken2_build.out
