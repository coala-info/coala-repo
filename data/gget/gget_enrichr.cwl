cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - enrichr
label: gget_enrichr
doc: 'Perform an enrichment analysis on a list of genes using Enrichr.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: genes
    type:
      type: array
      items: string
    doc: List of gene symbols or Ensembl gene IDs to perform enrichment analysis on.
    inputBinding:
      position: 1
  - id: database
    type: string
    doc: '''pathway'', ''transcription'', ''ontology'', ''diseases_drugs'', ''celltypes'',
      ''kinase_interactions''or any database listed at: https://maayanlab.cloud/Enrichr/#libraries
      or the species-specific libraries listed in the documentation'
    inputBinding:
      position: 102
      prefix: --database
  - id: background
    type:
      - 'null'
      - boolean
    doc: 'If True, use set of >20,000 default background genes listed here: https://github.com/pachterlab/gget/blob/main/gget/constants/enrichr_bkg_genes.txt.
      ONLY SUPPORTED FOR HUMAN/MOUSE SPECIES'
    inputBinding:
      position: 102
      prefix: --background
  - id: background_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of gene names/Ensembl IDs to be used as background genes. ONLY SUPPORTED
      FOR HUMAN/MOUSE SPECIES
    inputBinding:
      position: 102
      prefix: --background_list
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
    doc: Add this flag if genes are given as Ensembl gene IDs.
    inputBinding:
      position: 102
      prefix: --ensembl
  - id: ensembl_bkg
    type:
      - 'null'
      - boolean
    doc: Add this flag if background genes are given as Ensembl gene IDs.
    inputBinding:
      position: 102
      prefix: --ensembl_bkg
  - id: genes_deprecated
    type:
      - 'null'
      - type: array
        items: string
    doc: DEPRECATED - use positional argument instead. List of gene symbols or Ensembl
      gene IDs to perform enrichment analysis on.
    inputBinding:
      position: 102
      prefix: --genes
  - id: json
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - json is now the default output format (convert to csv using
      flag [--csv]).
    inputBinding:
      position: 102
      prefix: --json
  - id: kegg_out
    type:
      - 'null'
      - string
    doc: Path to file to save the highlighted KEGG pathway image, e.g. path/to/folder/kegg_pathway.png.
    inputBinding:
      position: 102
      prefix: --kegg_out
  - id: kegg_rank
    type:
      - 'null'
      - int
    doc: 'Candidate pathway rank to be plotted in KEGG pathway image. (default: 1)'
    inputBinding:
      position: 102
      prefix: --kegg_rank
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
    doc: 'Enrichr variant to query: human, mouse, fly, yeast, worm or fish. Default:
      ''human''.'
    inputBinding:
      position: 102
      prefix: --species
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
    doc: Enrichment results (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
  - id: kegg_image
    type:
      - 'null'
      - File
    doc: Highlighted KEGG pathway image (only when kegg_out is set).
    outputBinding:
      glob: $(inputs.kegg_out)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
