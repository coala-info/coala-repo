cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gencube
  - seqmeta
label: gencube_seqmeta
doc: "Search, retrieve, and integrate metadata of experimental sequencing data (NCBI SRA).\n\nAll gencube subcommands use NCBI Entrez Utilities and need network access and an email address (the wrapper writes it to the gencube configuration file in the working directory). Results are written to the gencube_output directory.\n\nTool homepage: https://github.com/snu-cdrc/gencube"
inputs:
  - id: email
    type: string
    doc: "Email address for NCBI E-utilities (stored in the gencube configuration file)."
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: "Optional NCBI API key (36 characters) for faster E-utilities requests."
  - id: organism
    type:
      - 'null'
      - string
    doc: "Scientific name or common name as found in the NCBI Taxonomy Browser (for example homo_sapiens or human)."
    inputBinding:
      position: 101
      prefix: --organism
  - id: strategy
    type:
      - 'null'
      - string
    doc: "Sequencing strategy, for example rna_seq, wgs, chip_seq, atac_seq, hi_c."
    inputBinding:
      position: 101
      prefix: --strategy
  - id: source
    type:
      - 'null'
      - string
    doc: "Source of the biological data: genomic, genomic_single_cell, metagenomic, metatranscriptomic, other, synthetic, transcriptomic, transcriptomic_single_cell or viral_rna."
    inputBinding:
      position: 101
      prefix: --source
  - id: platform
    type:
      - 'null'
      - string
    doc: "Name of the sequencing platform, for example illumina, oxford_nanopore, pacbio_smrt."
    inputBinding:
      position: 101
      prefix: --platform
  - id: selection
    type:
      - 'null'
      - string
    doc: "Library selection methodology, for example cdna, polya, random, chip."
    inputBinding:
      position: 101
      prefix: --selection
  - id: filter
    type:
      - 'null'
      - string
    doc: "Find SRA records that are cross-referenced with other NCBI databases, or filter by file type, platform or strategy (for example sra_public, filetype_fastq, library_layout_paired)."
    inputBinding:
      position: 101
      prefix: --filter
  - id: properties
    type:
      - 'null'
      - string
    doc: "Narrow search results by controlled-vocabulary library annotations (for example filetype_fastq, instrument_illumina_novaseq_6000)."
    inputBinding:
      position: 101
      prefix: --properties
  - id: layout
    type:
      - 'null'
      - string
    doc: "Library layout of the sequencing data: paired or single."
    inputBinding:
      position: 101
      prefix: --layout
  - id: access
    type:
      - 'null'
      - string
    doc: "Data accessibility: public or controlled."
    inputBinding:
      position: 101
      prefix: --access
  - id: bioproject
    type:
      - 'null'
      - string
    doc: "BioProject accession in the form of PRJNA#, PRJEB# or PRJDB#."
    inputBinding:
      position: 101
      prefix: --bioproject
  - id: biosample
    type:
      - 'null'
      - string
    doc: "BioSample accession in the form of SAMN#, SAMEA# or SAMD#."
    inputBinding:
      position: 101
      prefix: --biosample
  - id: accession
    type:
      - 'null'
      - string
    doc: "SRA/ENA/DDBJ accession of a study (SRP#, ERP#, DRP#), sample (SRS#, ERS#, DRS#), experiment (SRX#, ERX#, DRX#) or run (SRR#, ERR#, DRR#)."
    inputBinding:
      position: 101
      prefix: --accession
  - id: title
    type:
      - 'null'
      - string
    doc: "Descriptive name of the dataset."
    inputBinding:
      position: 101
      prefix: --title
  - id: author
    type:
      - 'null'
      - string
    doc: "Researcher or group that submitted the data."
    inputBinding:
      position: 101
      prefix: --author
  - id: publication
    type:
      - 'null'
      - string
    doc: "Publication date range in YYYY.MM.DD format (for example 2016, 2016.07, 2016.07:2023.02)."
    inputBinding:
      position: 101
      prefix: --publication
  - id: modification
    type:
      - 'null'
      - string
    doc: "Modification date range in YYYY.MM.DD format (for example 2016.07:2023.02)."
    inputBinding:
      position: 101
      prefix: --modification
  - id: readlength
    type:
      - 'null'
      - string
    doc: "Length of the sequencing reads, a value or a range (for example 100 or 100:500)."
    inputBinding:
      position: 101
      prefix: --readlength
  - id: mbases
    type:
      - 'null'
      - string
    doc: "Number of mega bases in the SRA runs."
    inputBinding:
      position: 101
      prefix: --mbases
  - id: textword
    type:
      - 'null'
      - string
    doc: "General search term for finding datasets by specific words in metadata."
    inputBinding:
      position: 101
      prefix: --textword
  - id: exclude
    type:
      - 'null'
      - string
    doc: "Exclude the results for these keywords (comma separated, for example cell_line,normal,crispr)."
    inputBinding:
      position: 101
      prefix: --exclude
  - id: detail
    type:
      - 'null'
      - boolean
    doc: "Show the number of searched results for each option and keyword."
    inputBinding:
      position: 101
      prefix: --detail
  - id: url
    type:
      - 'null'
      - boolean
    doc: "Save the file, including the URL address of the raw data (.fastq)."
    inputBinding:
      position: 101
      prefix: --url
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: "Save integrated metadata."
    inputBinding:
      position: 101
      prefix: --metadata
  - id: keywords
    type:
      - 'null'
      - type: array
        items: string
    doc: "Keywords to search for sequencing-based experimental data (for example liver, k562, cancer). Keywords separated by commas combine their results; separate words intersect their results."
    inputBinding:
      position: 200
outputs:
  - id: gencube_output
    type: Directory
    doc: "Directory with the search tables, metadata and URL files."
    outputBinding:
      glob: gencube_output
  - id: stdout
    type: stdout
    doc: "Search summary printed by gencube."
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .gencube_entrez_info
        entry: |-
          # This information is used in E-utilities
          email = $(inputs.email)
          api_key = $(inputs.ncbi_api_key ? inputs.ncbi_api_key : '')
      - entry: "$({class: 'Directory', basename: 'gencube_output', listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
stdout: gencube_seqmeta.out
