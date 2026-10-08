cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - archs4
label: gget_archs4
doc: 'Find the most correlated genes or the tissue expression atlas of a gene using
  data from the human and mouse RNA-seq database ARCHS4 (https://maayanlab.cloud/archs4/).


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: gene
    type: string
    doc: Gene symbol or Ensembl gene ID of gene of interest, e.g. 'STAT4'.
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
  - id: ensembl
    type:
      - 'null'
      - boolean
    doc: Add this flag if gene is given as an Ensembl gene ID.
    inputBinding:
      position: 102
      prefix: --ensembl
  - id: gene_count
    type:
      - 'null'
      - int
    doc: 'Number of correlated genes to return (default: 100). (Only for gene correlation.)'
    inputBinding:
      position: 102
      prefix: --gene_count
  - id: gene_deprecated
    type:
      - 'null'
      - string
    doc: DEPRECATED - use positional argument instead. Gene symbol or Ensembl gene
      ID of gene of interest (str), e.g. 'STAT4'.
    inputBinding:
      position: 102
      prefix: --gene
  - id: json
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - json is now the default output format (convert to csv using
      flag [--csv]).
    inputBinding:
      position: 102
      prefix: --json
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: species
    type:
      - 'null'
      - string
    doc: '''human'' (default) or ''mouse''. (Only for tissue expression atlas.)'
    inputBinding:
      position: 102
      prefix: --species
  - id: which
    type:
      - 'null'
      - string
    doc: '''correlation'' (default) or ''tissue''. ''correlation'' returns a gene
      correlation table that contains the 100 most correlated genes to the gene of
      interest. ''tissue'' returns a tissue expression atlas calculated from human
      or mouse samples (as defined by ''species'') in ARCHS4.'
    inputBinding:
      position: 102
      prefix: --which
  - id: out_path
    type: string
    default: results.json
    doc: Path to the csv file the results will be saved in, e.g. path/to/directory/results.csv.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Correlated genes or tissue expression atlas (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
