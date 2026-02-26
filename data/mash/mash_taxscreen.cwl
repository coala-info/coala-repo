cwlVersion: v1.2
class: CommandLineTool
baseCommand: mash_taxscreen
label: mash_taxscreen
doc: "Create Kraken-style taxonomic report based on how well query sequences are contained
  within a pool of sequences. The queries must be formatted as a single Mash sketch
  file (.msh), created with the `mash sketch` command. The <pool> files can be contigs
  or reads, in fasta or fastq, gzipped or not, and \"-\" can be given for <pool> to
  read from standard input. The <pool> sequences are assumed to be nucleotides, and
  will be 6-frame translated if the <queries> are amino acids. The output fields are
  [total percent of hashes, number of contained hashes in the clade, number of contained
  hashes in the taxon, total number of hashes in the clade, total number of hashes
  in the taxon, rank, taxonomy ID, padded name].\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: queries
    type: File
    doc: Mash sketch file (.msh) of query sequences
    inputBinding:
      position: 1
  - id: pool
    type:
      type: array
      items: File
    doc: Pool of sequences (contigs or reads, fasta/fastq, gzipped or not). '-' 
      for stdin.
    inputBinding:
      position: 2
  - id: mapping_file
    type:
      - 'null'
      - string
    doc: Mapping file from reference name to taxonomy ID
    inputBinding:
      position: 103
      prefix: -m
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: Maximum p-value to report.
    default: 1.0
    inputBinding:
      position: 103
      prefix: -v
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity to report. Inclusive unless set to zero, in which case
      only identities greater than zero (i.e. with at least one shared hash) 
      will be reported. Set to -1 to output everything.
    default: 0
    inputBinding:
      position: 103
      prefix: -i
  - id: taxonomy_dump_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing NCBI taxonomy dump
    default: .
    inputBinding:
      position: 103
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Parallelism. This many threads will be spawned for processing.
    default: 1
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_taxscreen.out
