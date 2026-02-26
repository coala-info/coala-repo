cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-subset-GTDB-accessions
label: gtotree_gtt-subset-GTDB-accessions
doc: "This script is a helper program of GToTree (https://github.com/AstrobioMike/GToTree/wiki)
  to facilitate subsetting accessions pulled from the GTDB database (with 'gtt-get-accessions-from-GTDB'
  – the input file is the \"*metadata.tsv\" from that program). It is intended to
  help when wanting a tree to span the breadth of diversity we know about, while also
  helping to reduce over-representation of certain taxa. There are 2 primary methods
  for using it: 1) If a specific Class makes up > 0.05% (by default) of the total
  number of target genomes, the script will randomly subset that class down to 1%
  of what it was. So if there are 40,000 total target genomes, and Gammaproteobacteria
  make up 8,000 of them (20% of the total), the program will randomly select 80 Gammaproteobacteria
  to include (1% of 8,000). 2) Select 1 random genome from each taxa of the specified
  rank. It ultimately outputs a new subset accessions file ready for use with the
  main GToTree program.\n\nTool homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs:
  - id: cutoff_fraction
    type:
      - 'null'
      - float
    doc: Fraction of total target genomes that any given Class must contribute 
      in order for that class to be randomly subset
    default: 0.0005
    inputBinding:
      position: 101
      prefix: --cutoff-fraction
  - id: fraction_to_subset
    type:
      - 'null'
      - float
    doc: Fraction those that are filtered should be randomly subset down to
    default: 0.01
    inputBinding:
      position: 101
      prefix: --fraction-to-subset
  - id: get_only_individuals_for_the_rank
    type:
      - 'null'
      - string
    doc: Use this option with a specified rank if wanting to randomly subset 
      such that we retain 1 genome from each entry in a specific rank in GTDB
    inputBinding:
      position: 101
      prefix: --get-only-individuals-for-the-rank
  - id: get_order_representatives_only
    type:
      - 'null'
      - boolean
    doc: Provide this flag to simply get 1 random genome from each Order in GTDB
      (same as if specifying `--get-only- individuals-for-the-rank order`, but 
      left here for backwards-compatibility purposes)
    inputBinding:
      position: 101
      prefix: --get-Order-representatives-only
  - id: gtdb_table
    type: File
    doc: GTDB metadata table produced with 'gtt-get-accessions-from-GTDB'
    inputBinding:
      position: 101
      prefix: --GTDB-table
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix for output subset accessions (*.txt) and GTDB taxonomy 
      files (*.tsv)
    default: '"subset-accessions"'
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: Specify the seed for random subsampling
    default: 1
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_gtt-subset-GTDB-accessions.out
