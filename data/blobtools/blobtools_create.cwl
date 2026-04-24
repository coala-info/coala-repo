cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools create
label: blobtools_create
doc: "Create a BlobDB from FASTA and associated data files.\n\nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM file(s), can be specified multiple times
    inputBinding:
      position: 101
      prefix: --bam
  - id: calculate_cov
    type:
      - 'null'
      - boolean
    doc: Legacy coverage when getting coverage from BAM (does not apply to COV 
      parsing). New default is to estimate coverages which is faster,
    inputBinding:
      position: 101
      prefix: --calculate_cov
  - id: cas_files
    type:
      - 'null'
      - type: array
        items: File
    doc: CAS file(s) (requires clc_mapping_info in $PATH), can be specified 
      multiple times
    inputBinding:
      position: 101
      prefix: --cas
  - id: cov_files
    type:
      - 'null'
      - type: array
        items: File
    doc: COV file(s), can be specified multiple times
    inputBinding:
      position: 101
      prefix: --cov
  - id: fasta_type
    type:
      - 'null'
      - string
    doc: Assembly program used to create FASTA. If specified, coverage will be 
      parsed from FASTA header. (Parsing supported for 'spades', 'velvet', 
      'platanus')
    inputBinding:
      position: 101
      prefix: --type
  - id: hits_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Hits file in format (qseqid\ttaxid\tbitscore) (e.g. BLAST output 
      "--outfmt '6 qseqid staxids bitscore'"). Can be specified multiple times
    inputBinding:
      position: 101
      prefix: --hitsfile
  - id: infile
    type: File
    doc: FASTA file of assembly. Headers are split at whitespaces.
    inputBinding:
      position: 101
      prefix: --infile
  - id: min_diff
    type:
      - 'null'
      - float
    doc: Minimal score difference between highest scoring taxonomies (otherwise 
      "unresolved")
    inputBinding:
      position: 101
      prefix: --min_diff
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimal score necessary to be considered for taxonomy calculaton, 
      otherwise set to 'no-hit'
    inputBinding:
      position: 101
      prefix: --min_score
  - id: names_file
    type:
      - 'null'
      - File
    doc: NCBI names.dmp file. Not required if '--db'
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes_db_file
    type:
      - 'null'
      - File
    doc: 'NodesDB file (default: $BLOBTOOLS/data/nodesDB.txt). If --nodes, --names
      and --db are all given and NODESDB does not exist, create it from NODES and
      NAMES.'
    inputBinding:
      position: 101
      prefix: --db
  - id: nodes_file
    type:
      - 'null'
      - File
    doc: NCBI nodes.dmp file. Not required if '--db'
    inputBinding:
      position: 101
      prefix: --nodes
  - id: output_prefix
    type: string
    doc: BlobDB output prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: tax_collision_random
    type:
      - 'null'
      - boolean
    doc: Random allocation of taxonomy if highest scoring taxonomies have equal 
      scores (otherwise "unresolved")
    inputBinding:
      position: 101
      prefix: --tax_collision_random
  - id: tax_rules
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Taxrule determines how taxonomy of blobs is computed (by default both are
      calculated) "bestsum" : sum bitscore across all hits for each taxonomic rank
      "bestsumorder" : sum bitscore across all hits for each taxonomic rank. - If
      first <TAX> file supplies hits, bestsum is calculated. - If no hit is found,
      the next <TAX> file is used.'
    inputBinding:
      position: 101
      prefix: --taxrule
  - id: title
    type:
      - 'null'
      - string
    doc: Title of BlobDB
    inputBinding:
      position: 101
      prefix: --title
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_create.out
