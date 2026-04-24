cwlVersion: v1.2
class: CommandLineTool
baseCommand: cazy_webscraper.py
label: cazy_webscraper
doc: "Scrapes the CAZy database\n\nTool homepage: https://hobnobmancer.github.io/cazy_webscraper/"
inputs:
  - id: email
    type: string
    doc: User email address. Requirement of Entrez, used to get source organsism
      data. Email is not stored be cazy_webscraper.
    inputBinding:
      position: 1
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Target path for cache dir to be used instead of default path
    inputBinding:
      position: 102
      prefix: --cache_dir
  - id: cazy_data
    type:
      - 'null'
      - File
    doc: Path predownloaded CAZy txt file
    inputBinding:
      position: 102
      prefix: --cazy_data
  - id: cazy_synonyms
    type:
      - 'null'
      - File
    doc: Path to JSON file containing CAZy class synoymn names
    inputBinding:
      position: 102
      prefix: --cazy_synonyms
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print cazy_webscraper citation message
    inputBinding:
      position: 102
      prefix: --citation
  - id: classes
    type:
      - 'null'
      - string
    doc: Classes from which all families are to be scraped. Separate classes by 
      ','
    inputBinding:
      position: 102
      prefix: --classes
  - id: config_file
    type:
      - 'null'
      - File
    doc: 'Path to configuration file. Default: None, scrapes entire database'
    inputBinding:
      position: 102
      prefix: --config
  - id: database
    type:
      - 'null'
      - File
    doc: Path to an existing local CAZy SQL database
    inputBinding:
      position: 102
      prefix: --database
  - id: delete_old_relationships
    type:
      - 'null'
      - boolean
    doc: Delete old GenBank accession - CAZy family relationships (annotations) 
      that are in the local db but are not in CAZy, e.g. when CAZy has moved a 
      protein from one fam to another, delete the old family annotation.
    inputBinding:
      position: 102
      prefix: --delete_old_relationships
  - id: families
    type:
      - 'null'
      - string
    doc: Families to scrape. Separate families by commas 'GH1,GH2' (case 
      sensitive)
    inputBinding:
      position: 102
      prefix: --families
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force file over writting
    inputBinding:
      position: 102
      prefix: --force
  - id: genera
    type:
      - 'null'
      - string
    doc: Genera to restrict the scrape to
    inputBinding:
      position: 102
      prefix: --genera
  - id: kingdoms
    type:
      - 'null'
      - string
    doc: Tax Kingdoms to restrict the scrape to
    inputBinding:
      position: 102
      prefix: --kingdoms
  - id: log_file_name
    type:
      - 'null'
      - File
    doc: Defines log file name and/or path
    inputBinding:
      position: 102
      prefix: --log
  - id: ncbi_batch_size
    type:
      - 'null'
      - int
    doc: Number of genbank accessions in each NCBI Taxonomy db batch query
    inputBinding:
      position: 102
      prefix: --ncbi_batch_size
  - id: nodelete
    type:
      - 'null'
      - boolean
    doc: When called, content in the existing out dir is NOT deleted
    inputBinding:
      position: 102
      prefix: --nodelete
  - id: nodelete_cache
    type:
      - 'null'
      - boolean
    doc: When called, content in the existing cache dir is NOT deleted
    inputBinding:
      position: 102
      prefix: --nodelete_cache
  - id: nodelete_log
    type:
      - 'null'
      - boolean
    doc: When called, content in the existing log dir is NOT deleted
    inputBinding:
      position: 102
      prefix: --nodelete_log
  - id: retries
    type:
      - 'null'
      - int
    doc: Number of times to retry scraping a family or class page if error 
      encountered
    inputBinding:
      position: 102
      prefix: --retries
  - id: skip_ncbi_tax
    type:
      - 'null'
      - boolean
    doc: Skip retrieving the latest tax classification from the NCBI Taxonomy db
      for proteins listed with multiple taxs in CAZy. For these proteins the 
      first taxonomy listed in CAZy is added to the local CAZyme db
    inputBinding:
      position: 102
      prefix: --skip_ncbi_tax
  - id: species
    type:
      - 'null'
      - string
    doc: Species (written as Genus Species) to restrict the scrape to
    inputBinding:
      position: 102
      prefix: --species
  - id: sql_echo
    type:
      - 'null'
      - boolean
    doc: Set SQLite engine echo to True (SQLite will print its log messages)
    inputBinding:
      position: 102
      prefix: --sql_echo
  - id: strains
    type:
      - 'null'
      - string
    doc: Specific strains of organisms to restrict the scrape to (written as 
      Genus Species Strain)
    inputBinding:
      position: 102
      prefix: --strains
  - id: subfamilies
    type:
      - 'null'
      - boolean
    doc: Enable retrieval of subfamilies from CAZy
    inputBinding:
      position: 102
      prefix: --subfamilies
  - id: timeout
    type:
      - 'null'
      - int
    doc: Connection timeout limit (seconds)
    inputBinding:
      position: 102
      prefix: --timeout
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Retrieve CAZy fam population sizes from CAZy and use to check the 
      number of family members added to the local database
    inputBinding:
      position: 102
      prefix: --validate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set logger level to 'INFO'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: db_output
    type:
      - 'null'
      - Directory
    doc: Target output path to build new SQL database
    outputBinding:
      glob: $(inputs.db_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cazy_webscraper:2.3.0.4--pyhdfd78af_0
