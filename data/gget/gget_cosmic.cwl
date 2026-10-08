cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - cosmic
label: gget_cosmic
doc: 'Query information about genes, mutations, etc. associated with cancers from
  the COSMIC database.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: searchterm
    type:
      - 'null'
      - string
    doc: 'Search term, which can be a mutation, gene name (or Ensembl ID), sample,
      etc. Examples: EGFR (entity mutations), v600e (mutations), COSV57014428 (mutations),
      EGFR (genes), prostate (cancer or tumour_site), ICGC (studies or samples), EGFR
      (pubmed), COSS2907494 (samples).'
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Returns results in csv format instead of json.
    inputBinding:
      position: 102
      prefix: --csv
  - id: cosmic_version
    type:
      - 'null'
      - string
    doc: 'Version of the COSMIC database (only for use with --download_cosmic). Default:
      None -> Defaults to latest version.'
    inputBinding:
      position: 102
      prefix: --cosmic_version
  - id: download_cosmic
    type:
      - 'null'
      - boolean
    doc: Switch into database download mode.
    inputBinding:
      position: 102
      prefix: --download_cosmic
  - id: entity
    type:
      - 'null'
      - string
    doc: 'Defines the type of the results to return: mutations (default), genes, cancer,
      tumour_site, studies, pubmed or samples.'
    inputBinding:
      position: 102
      prefix: --entity
  - id: grch_version
    type:
      - 'null'
      - int
    doc: 'Version of the human GRCh reference genome, 37 or 38 (only for use with
      --download_cosmic). (default: 37)'
    inputBinding:
      position: 102
      prefix: --grch_version
  - id: gget_mutate
    type:
      - 'null'
      - boolean
    doc: Do NOT create a modified version of the database for use with gget mutate
      (only for use with --download_cosmic).
    inputBinding:
      position: 102
      prefix: --gget_mutate
  - id: keep_genome_info
    type:
      - 'null'
      - boolean
    doc: Whether to keep genome information (e.g. location of mutation in the genome)
      in the modified database for use with gget mutate (only for use with --download_cosmic).
    inputBinding:
      position: 102
      prefix: --keep_genome_info
  - id: limit
    type:
      - 'null'
      - int
    doc: 'Number of hits to return. (default: 100)'
    inputBinding:
      position: 102
      prefix: --limit
  - id: mutation_class
    type:
      - 'null'
      - string
    doc: 'Type of COSMIC database to download (only for use with --download_cosmic):
      cancer, cell_line, census, resistance, genome_screen, targeted_screen or cancer_example.
      (default: cancer)'
    inputBinding:
      position: 102
      prefix: --mutation_class
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Whether to remove duplicated rows from the modified database for use with
      gget mutate (only for use with --download_cosmic).
    inputBinding:
      position: 102
      prefix: --remove_duplicates
  - id: out_path
    type: string
    default: results.json
    doc: Path to the file (or folder when downloading databases with the download_cosmic
      flag) the results will be saved in, e.g. path/to/results.json.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
      - Directory
    doc: Query results (JSON, or CSV with --csv), or the folder with the downloaded
      database.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
