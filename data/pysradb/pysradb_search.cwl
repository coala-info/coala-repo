cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb search
label: pysradb_search
doc: "Search for data in SRA, ENA, or GEO databases.\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: Accession number
    inputBinding:
      position: 101
      prefix: --accession
  - id: db
    type:
      - 'null'
      - string
    doc: "Select the db API (sra, ena, or geo) to query, default = sra. Note: pysradb
      search works slightly differently when db = geo. Please refer to 'pysradb search
      --geo-info' for more details."
    default: sra
    inputBinding:
      position: 101
      prefix: --db
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Displays detailed search results. Equivalent to --verbosity 3.
    inputBinding:
      position: 101
      prefix: --detailed
  - id: geo_dataset_type
    type:
      - 'null'
      - type: array
        items: string
    doc: GEO DataSet Type. This flag is only used when --db is set to be 
      geo.Please refer to 'pysradb search --geo-info' for more details.
    inputBinding:
      position: 101
      prefix: --geo-dataset-type
  - id: geo_entry_type
    type:
      - 'null'
      - type: array
        items: string
    doc: GEO Entry Type. This flag is only used when --db is set to be 
      geo.Please refer to 'pysradb search --geo-info' for more details.
    inputBinding:
      position: 101
      prefix: --geo-entry-type
  - id: geo_info
    type:
      - 'null'
      - boolean
    doc: Displays information on how to query GEO DataSets via 'pysradb search 
      --db geo ...', including accepted inputs for -G/--geo-query, 
      -Y/--geo-dataset-type and -Z/--geo-entry-type.
    inputBinding:
      position: 101
      prefix: --geo-info
  - id: geo_query
    type:
      - 'null'
      - type: array
        items: string
    doc: Main query string for GEO DataSet. This flag is only used when db is 
      set to be geo.Please refer to 'pysradb search --geo-info' for more 
      details.
    inputBinding:
      position: 101
      prefix: --geo-query
  - id: graphs
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Generates graphs to illustrate the search result. By default all graphs
      are generated. Alternatively, select a subset from the options below in a space-separated
      string: daterange, organism, source, selection, platform, basecount'
    inputBinding:
      position: 101
      prefix: --graphs
  - id: library_layout
    type:
      - 'null'
      - string
    doc: Library layout. Accepts either SINGLE or PAIRED
    inputBinding:
      position: 101
      prefix: --layout
  - id: max_entries
    type:
      - 'null'
      - int
    doc: Maximum number of entries to return, default = 20
    default: 20
    inputBinding:
      position: 101
      prefix: --max
  - id: mbases
    type:
      - 'null'
      - int
    doc: Size of the sample rounded to the nearest megabase
    inputBinding:
      position: 101
      prefix: --mbases
  - id: organism
    type:
      - 'null'
      - type: array
        items: string
    doc: Scientific name of the sample organism
    inputBinding:
      position: 101
      prefix: --organism
  - id: platform
    type:
      - 'null'
      - type: array
        items: string
    doc: Sequencing platform
    inputBinding:
      position: 101
      prefix: --platform
  - id: publication_date
    type:
      - 'null'
      - string
    doc: "Publication date of the run in the format dd-mm-yyyy. If a date range is
      desired, enter the start date, followed by end date, separated by a colon ':'.
      Example: 01-01-2010:31-12-2010"
    inputBinding:
      position: 101
      prefix: --publication-date
  - id: query
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Main query string. Note that if no query is supplied, at least one of the
      following flags must be present:'
    inputBinding:
      position: 101
      prefix: --query
  - id: run_description
    type:
      - 'null'
      - boolean
    doc: Displays run accessions and descriptions only. Equivalent to 
      --verbosity 1
    inputBinding:
      position: 101
      prefix: --run-description
  - id: selection
    type:
      - 'null'
      - type: array
        items: string
    doc: Library selection
    inputBinding:
      position: 101
      prefix: --selection
  - id: source
    type:
      - 'null'
      - type: array
        items: string
    doc: Library source
    inputBinding:
      position: 101
      prefix: --source
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Displays some useful statistics for the search results.
    inputBinding:
      position: 101
      prefix: --stats
  - id: strategy
    type:
      - 'null'
      - type: array
        items: string
    doc: Library preparation strategy
    inputBinding:
      position: 101
      prefix: --strategy
  - id: title
    type:
      - 'null'
      - type: array
        items: string
    doc: Experiment title
    inputBinding:
      position: 101
      prefix: --title
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Level of search result details (0, 1, 2 or 3), default = 2 0: run accession
      only 1: run accession and experiment title 2: accession numbers, titles and
      sequencing information 3: records in 2 and other information such as download
      url, sample attributes, etc'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: save_to
    type:
      - 'null'
      - File
    doc: Save search result dataframe to file
    outputBinding:
      glob: $(inputs.save_to)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
