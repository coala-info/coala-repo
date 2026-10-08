cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - bgee
label: gget_bgee
doc: 'Query the Bgee database for orthology and gene expression data using Ensembl
  IDs.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: ens_id
    type: string
    doc: Ensembl gene ID, e.g. ENSG00000169194 or ENSSSCG00000014725.
    inputBinding:
      position: 1
  - id: type
    type: string
    doc: 'Type of information to be returned: orthologs or expression.'
    inputBinding:
      position: 102
      prefix: --type
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Returns results in csv format instead of json.
    inputBinding:
      position: 102
      prefix: --csv
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: out_path
    type: string
    default: results.json
    doc: Path to the file the results will be saved in, e.g. path/to/directory/results.json.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Bgee orthology or expression results (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
