cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-get-accessions-from-GTDB
label: gtotree_gtt-get-accessions-from-GTDB
doc: "This is a helper program to facilitate using taxonomy and genomes from the Genome
  Taxonomy Database (gtdb.ecogenomic.org) with GToTree. It primarily returns NCBI
  accessions and GTDB summary tables based on GTDB-taxonomy searches. It also currently
  has filtering capabilities built-in for specifying only GTDB representative species
  or RefSeq representative genomes (see help menu and links therein for explanations
  of what these are). For examples, please visit the GToTree wiki here: github.com/AstrobioMike/GToTree/wiki/example-usage\n\
  \nTool homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs:
  - id: do_not_check_gtdb_version
    type:
      - 'null'
      - boolean
    doc: By default, this program checks if it is using the latest version of 
      the GTDB database. Provide this flag to prevent this from occurring, using
      the version already present.
    inputBinding:
      position: 101
      prefix: --do-not-check-GTDB-version
  - id: get_rank_counts
    type:
      - 'null'
      - boolean
    doc: Provide just this flag alone to see counts of how many unique taxa 
      there are for each rank.
    inputBinding:
      position: 101
      prefix: --get-rank-counts
  - id: get_table
    type:
      - 'null'
      - boolean
    doc: Provide just this flag alone to download and parse a GTDB metadata 
      table. Archaea and Bacteria tables pulled from here 
      (https://data.gtdb.ecogenomic.org/releases/latest/) and combined, and the 
      GTDB taxonomy column is split for easier manual searching if wanted.
    inputBinding:
      position: 101
      prefix: --get-table
  - id: get_taxon_counts
    type:
      - 'null'
      - boolean
    doc: Provide this flag along with a specified taxon to the -t flag to see 
      how many of that taxon are in the database.
    inputBinding:
      position: 101
      prefix: --get-taxon-counts
  - id: gtdb_representatives_only
    type:
      - 'null'
      - boolean
    doc: 'Provide this flag along with a specified taxon to the -t flag to pull accessions
      only for genomes designated as GTDB species representatives (see e.g.: https://gtdb.ecogenomic.org/faq#gtdb_species_clusters).'
    inputBinding:
      position: 101
      prefix: --GTDB-representatives-only
  - id: refseq_representatives_only
    type:
      - 'null'
      - boolean
    doc: 'Provide this flag along with a specified taxon to the -t flag to pull accessions
      only for genomes designated as RefSeq representative genomes (see e.g.: https://www.ncbi.nlm.nih.gov/refseq/about/prokaryotes/
      #representative_genomes). (Useful for subsetting a view across a broad level
      of diversity, see also `gtt-subset-GTDB-accessions`.)'
    inputBinding:
      position: 101
      prefix: --RefSeq-representatives-only
  - id: store_gtdb_metadata_in_current_working_dir
    type:
      - 'null'
      - boolean
    doc: By default, GToTree uses a system-wide variable to know where to put 
      and search the GTDB metadata. Provide this flag to ignore that and store 
      the master table in the current working directory.
    inputBinding:
      position: 101
      prefix: --store-GTDB-metadata-in-current-working-dir
  - id: target_rank
    type:
      - 'null'
      - string
    doc: Target rank
    inputBinding:
      position: 101
      prefix: --target-rank
  - id: target_taxon
    type:
      - 'null'
      - string
    doc: Target taxon (enter 'all' for all)
    inputBinding:
      position: 101
      prefix: --target-taxon
  - id: use_ecogenomics
    type:
      - 'null'
      - boolean
    doc: By default, we try to pull the data from 
      'https://data.ace.uq.edu.au/public/gtdb/data/releases/latest/' instead of 
      'https://data.gtdb.ecogenomic.org/releases/latest/'. Add this flag to try 
      to pull from the ecogenomics site (might be much slower depending on where
      you are).
    inputBinding:
      position: 101
      prefix: --use-ecogenomics
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_gtt-get-accessions-from-GTDB.out
