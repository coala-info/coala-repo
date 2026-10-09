cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-build
label: krakenhll_build
doc: "Build a KrakenHLL database. Exactly one task option can be selected per call (default is build). The add-to-library task always ends with exit code 255 (the script ends with exit -1), so 255 is accepted.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs:
  - id: db
    type: Directory
    doc: KrakenHLL DB folder; it is copied into the working directory as krakenhll_db and returned updated
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
    doc: Download partial library (refseq/bacteria, refseq/archaea or refseq/viral)
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
    doc: Download and create default database (complete genomes for archaea, bacteria and viruses from RefSeq, and viral strains from NCBI)
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
  - id: jellyfish_bin
    type:
      - 'null'
      - string
    doc: Use STR as Jellyfish 1 binary
    inputBinding:
      position: 25
      prefix: --jellyfish-bin
  - id: max_db_size
    type:
      - 'null'
      - float
    doc: Shrink the DB before full build, making sure database and index together use <= SIZE gigabytes (build task only)
    inputBinding:
      position: 26
      prefix: --max-db-size
  - id: shrink_block_offset
    type:
      - 'null'
      - int
    doc: When shrinking, select the k-mer that is NUM positions from the end of a block of k-mers (default 1)
    inputBinding:
      position: 27
      prefix: --shrink-block-offset
  - id: lca_database
    type:
      - 'null'
      - boolean
    doc: Build a LCA database (default yes)
    inputBinding:
      position: 28
      prefix: --lca-database
  - id: no_lca_database
    type:
      - 'null'
      - boolean
    doc: Do not build a LCA database
    inputBinding:
      position: 29
      prefix: --no-lca-database
  - id: work_on_disk
    type:
      - 'null'
      - boolean
    doc: Perform most operations on disk rather than in RAM (will slow down build in most cases)
    inputBinding:
      position: 30
      prefix: --work-on-disk
  - id: taxids_for_genomes
    type:
      - 'null'
      - boolean
    doc: Add taxonomy IDs (starting with 1 billion) for genomes; needs a 3-column seqid2taxid map with the name in the third column
    inputBinding:
      position: 31
      prefix: --taxids-for-genomes
  - id: taxids_for_sequences
    type:
      - 'null'
      - boolean
    doc: Add taxonomy IDs for sequences, starting with 1 billion
    inputBinding:
      position: 32
      prefix: --taxids-for-sequences
  - id: library_dir
    type:
      - 'null'
      - string
    doc: Use DIR for reference sequences instead of DBDIR/library
    inputBinding:
      position: 33
      prefix: --library-dir
  - id: taxonomy_dir
    type:
      - 'null'
      - string
    doc: Use DIR for taxonomy instead of DBDIR/taxonomy
    inputBinding:
      position: 34
      prefix: --taxonomy-dir
  - id: uid_database
    type:
      - 'null'
      - boolean
    doc: Build a UID database (experimental; default no)
    inputBinding:
      position: 35
      prefix: --uid-database
arguments:
  - position: 1
    prefix: --db
    valueFrom: krakenhll_db
outputs:
  - id: db_out
    type: Directory
    doc: The updated KrakenHLL DB folder
    outputBinding:
      glob: krakenhll_db
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
        entryname: krakenhll_db
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
successCodes:
  - 0
  - 255
stdout: krakenhll_build.out
