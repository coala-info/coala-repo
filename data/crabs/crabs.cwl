cwlVersion: v1.2
class: CommandLineTool
baseCommand: crabs
label: crabs
doc: "CRABS is an open-source software program that enables scientists to build custom
  local reference databases for improved taxonomy assignment of metabarcoding data.\n\
  CRABS is split up into various functions and steps to accomplish this task, including:\n\
  (1) download data from online repositories,\n(2) import downloaded data into CRABS
  format,\n(3) extract amplicons from imported data,\n(4) retrieve amplicons without
  primer-binding regions,\n(5) curate and subset the local database,\n(6) export the
  local database in various taxonomic classifier formats, and\n(7) basic visualisations
  to explore the local reference database.\n\nTool homepage: https://github.com/gjeunen/reference_database_creator"
inputs:
  - id: acc2tax
    type:
      - 'null'
      - File
    doc: NCBI taxonomy 'nucl_gb.accession2taxid' file
    inputBinding:
      position: 101
      prefix: --acc2tax
  - id: all_start_positions
    type:
      - 'null'
      - boolean
    doc: do not restrict alignment start and end to be within the primer-binding
      region length
    inputBinding:
      position: 101
      prefix: --all-start-positions
  - id: amplicon_length_figure
    type:
      - 'null'
      - boolean
    doc: Function to create a line chart depicting amplicon distributions
    inputBinding:
      position: 101
      prefix: --amplicon-length-figure
  - id: amplicons
    type:
      - 'null'
      - string
    doc: file name for the amplicons retrieved during in silico PCR
    inputBinding:
      position: 101
      prefix: --amplicons
  - id: amplification_efficiency_figure
    type:
      - 'null'
      - boolean
    doc: Function to create a bar graph displaying mismatches in the 
      primer-binding region
    inputBinding:
      position: 101
      prefix: --amplification-efficiency-figure
  - id: batchsize
    type:
      - 'null'
      - int
    doc: sequences to download from NCBI per chunk
    default: 5000
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: value 2x the longest sequence in the data, only necessary when 
      observing an 'OverflowError'
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: completeness_table
    type:
      - 'null'
      - boolean
    doc: Function creating a spreadsheet containing barcode availability for 
      taxonomic groups
    inputBinding:
      position: 101
      prefix: --completeness-table
  - id: coverage
    type:
      - 'null'
      - string
    doc: minimum coverage threshold for the alignment to pass (0 - 100)
    inputBinding:
      position: 101
      prefix: --coverage
  - id: database
    type:
      - 'null'
      - string
    doc: the database from which NCBI sequences are downloaded
    inputBinding:
      position: 101
      prefix: --database
  - id: db_type
    type:
      - 'null'
      - string
    doc: database version to download
    inputBinding:
      position: 101
      prefix: --db-type
  - id: db_version
    type:
      - 'null'
      - string
    doc: database version to download
    inputBinding:
      position: 101
      prefix: --db-version
  - id: dereplicate
    type:
      - 'null'
      - boolean
    doc: Function to dereplicate a CRABS database
    inputBinding:
      position: 101
      prefix: --dereplicate
  - id: dereplication_method
    type:
      - 'null'
      - string
    doc: 'dereplication method: "strict", "single_species", and "unique_species"'
    default: unique_species
    inputBinding:
      position: 101
      prefix: --dereplication-method
  - id: diversity_figure
    type:
      - 'null'
      - boolean
    doc: Function to create a horizontal bar chart with included diversity
    inputBinding:
      position: 101
      prefix: --diversity-figure
  - id: download_bold
    type:
      - 'null'
      - boolean
    doc: Function to download BOLD database
    inputBinding:
      position: 101
      prefix: --download-bold
  - id: download_embl
    type:
      - 'null'
      - boolean
    doc: Function to download EMBL database
    inputBinding:
      position: 101
      prefix: --download-embl
  - id: download_greengenes
    type:
      - 'null'
      - boolean
    doc: Function to download GreenGenes database
    inputBinding:
      position: 101
      prefix: --download-greengenes
  - id: download_greengenes2
    type:
      - 'null'
      - boolean
    doc: Function to downlaod GreenGenes2 database
    inputBinding:
      position: 101
      prefix: --download-greengenes2
  - id: download_meta_fish_lib
    type:
      - 'null'
      - boolean
    doc: Function to download the Meta-Fish-Lib database
    inputBinding:
      position: 101
      prefix: --download-meta-fish-lib
  - id: download_midori
    type:
      - 'null'
      - boolean
    doc: Function to download MIDORI2 database
    inputBinding:
      position: 101
      prefix: --download-midori
  - id: download_mitofish
    type:
      - 'null'
      - boolean
    doc: Function to download MitoFish database
    inputBinding:
      position: 101
      prefix: --download-mitofish
  - id: download_ncbi
    type:
      - 'null'
      - boolean
    doc: Function to download NCBI database
    inputBinding:
      position: 101
      prefix: --download-ncbi
  - id: download_silva
    type:
      - 'null'
      - boolean
    doc: Function to download SILVA database
    inputBinding:
      position: 101
      prefix: --download-silva
  - id: download_taxonomy
    type:
      - 'null'
      - boolean
    doc: Function to download NCBI taxonomy
    inputBinding:
      position: 101
      prefix: --download-taxonomy
  - id: email
    type:
      - 'null'
      - string
    doc: email address to connect to NCBI server
    inputBinding:
      position: 101
      prefix: --email
  - id: environmental
    type:
      - 'null'
      - boolean
    doc: discard environmental sequences from the database
    inputBinding:
      position: 101
      prefix: --environmental
  - id: exclude
    type:
      - 'null'
      - string
    doc: stop the download of 'acc2taxid' or 'taxdump'
    inputBinding:
      position: 101
      prefix: --exclude
  - id: export
    type:
      - 'null'
      - boolean
    doc: Function to export a CRABS database
    inputBinding:
      position: 101
      prefix: --export
  - id: export_format
    type:
      - 'null'
      - string
    doc: 'export format: "sintax", "rdp", "qiime-fasta", "qiime-text", "dada2-species",
      "dada2-taxonomy", "idt-fasta", "idt-text", "blast-notax", "blast-tax"'
    inputBinding:
      position: 101
      prefix: --export-format
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Function to filter a CRABS database
    inputBinding:
      position: 101
      prefix: --filter
  - id: forward
    type:
      - 'null'
      - string
    doc: forward primer sequence in 5' -> 3' direction
    inputBinding:
      position: 101
      prefix: --forward
  - id: gb_number
    type:
      - 'null'
      - string
    doc: database version to download
    inputBinding:
      position: 101
      prefix: --gb-number
  - id: gb_type
    type:
      - 'null'
      - string
    doc: database type to download
    inputBinding:
      position: 101
      prefix: --gb-type
  - id: gene
    type:
      - 'null'
      - string
    doc: gene to download
    inputBinding:
      position: 101
      prefix: --gene
  - id: import
    type:
      - 'null'
      - boolean
    doc: Function to import sequences into CRABS format
    inputBinding:
      position: 101
      prefix: --import
  - id: import_format
    type:
      - 'null'
      - string
    doc: format of the sequences to import
    inputBinding:
      position: 101
      prefix: --import-format
  - id: in_silico_pcr
    type:
      - 'null'
      - boolean
    doc: Function to extract amplicons through in silico PCR
    inputBinding:
      position: 101
      prefix: --in-silico-pcr
  - id: include
    type:
      - 'null'
      - string
    doc: string or file containing taxa to include
    inputBinding:
      position: 101
      prefix: --include
  - id: input
    type:
      - 'null'
      - File
    doc: input filename
    inputBinding:
      position: 101
      prefix: --input
  - id: marker
    type:
      - 'null'
      - string
    doc: genetic marker to download
    inputBinding:
      position: 101
      prefix: --marker
  - id: maximum_length
    type:
      - 'null'
      - int
    doc: maximum sequence length for amplicon to be retained in the database
    inputBinding:
      position: 101
      prefix: --maximum-length
  - id: maximum_n
    type:
      - 'null'
      - int
    doc: discard amplicons with N or more ambiguous bases
    inputBinding:
      position: 101
      prefix: --maximum-n
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Function to merge CRABS databases into a single file
    inputBinding:
      position: 101
      prefix: --merge
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: minimum sequence length for amplicon to be retained in the database
    inputBinding:
      position: 101
      prefix: --minimum-length
  - id: mismatch
    type:
      - 'null'
      - float
    doc: number of mismatches allowed in the primer-binding site
    default: 4
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: names
    type:
      - 'null'
      - File
    doc: NCBI taxonomy 'names.dmp' file
    inputBinding:
      position: 101
      prefix: --names
  - id: no_species_id
    type:
      - 'null'
      - boolean
    doc: discard sequences for which no species name is available
    inputBinding:
      position: 101
      prefix: --no-species-id
  - id: nodes
    type:
      - 'null'
      - File
    doc: NCBI taxonomy 'nodes.dmp' file
    inputBinding:
      position: 101
      prefix: --nodes
  - id: pairwise_global_alignment
    type:
      - 'null'
      - boolean
    doc: Function to retrieve amplicons without primer-bidning regions
    inputBinding:
      position: 101
      prefix: --pairwise-global-alignment
  - id: percent_identity
    type:
      - 'null'
      - string
    doc: minimum percent identity threshold for the alignment to pass (0.0 - 
      1.0)
    inputBinding:
      position: 101
      prefix: --percent-identity
  - id: phylogenetic_tree
    type:
      - 'null'
      - boolean
    doc: Function to create a phylogenetic tree with barcodes for target species
      list
    inputBinding:
      position: 101
      prefix: --phylogenetic-tree
  - id: query
    type:
      - 'null'
      - string
    doc: query identifying what to download from NCBI
    inputBinding:
      position: 101
      prefix: --query
  - id: rank_na
    type:
      - 'null'
      - int
    doc: discard sequences with N or more unspecified taxonomic levels
    inputBinding:
      position: 101
      prefix: --rank-na
  - id: ranks
    type:
      - 'null'
      - string
    doc: taxonomic ranks to be included in the taxonomic lineage
    inputBinding:
      position: 101
      prefix: --ranks
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: recover amplicons where only the forward or reverse primer-binding 
      region was found
    inputBinding:
      position: 101
      prefix: --relaxed
  - id: reverse
    type:
      - 'null'
      - string
    doc: reverse primer sequence in 5' -> 3' direction
    inputBinding:
      position: 101
      prefix: --reverse
  - id: size_select
    type:
      - 'null'
      - string
    doc: exclude reads longer than N from the analysis
    inputBinding:
      position: 101
      prefix: --size-select
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: species of interest list
    inputBinding:
      position: 101
      prefix: --species
  - id: subset
    type:
      - 'null'
      - boolean
    doc: Function to subset a CRABS database
    inputBinding:
      position: 101
      prefix: --subset
  - id: tax_group
    type:
      - 'null'
      - string
    doc: taxonomic group of interest to be included in the analysis
    inputBinding:
      position: 101
      prefix: --tax-group
  - id: tax_level
    type:
      - 'null'
      - int
    doc: taxonomic level to be used as groups for horizontal bar chart
    inputBinding:
      position: 101
      prefix: --tax-level
  - id: taxon
    type:
      - 'null'
      - string
    doc: taxonomic group to download
    inputBinding:
      position: 101
      prefix: --taxon
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads used to compute the in silico PCR
    default: autodetection
    inputBinding:
      position: 101
      prefix: --threads
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: keep only unique accession numbers
    inputBinding:
      position: 101
      prefix: --uniq
  - id: untrimmed
    type:
      - 'null'
      - string
    doc: file name for untrimmed sequences
    inputBinding:
      position: 101
      prefix: --untrimmed
  - id: version_v3
    type:
      - 'null'
      - boolean
    doc: download data from BOLD v3 (legacy)
    inputBinding:
      position: 101
      prefix: --version-v3
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output directory or filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crabs:1.14.0--pyhdfd78af_0
