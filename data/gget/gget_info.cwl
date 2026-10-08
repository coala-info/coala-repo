cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - info
label: gget_info
doc: 'Fetch gene and transcript metadata using Ensembl IDs.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: ens_ids
    type:
      type: array
      items: string
    doc: One or more Ensembl, WormBase, or FlyBase IDs.
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
  - id: ensembl_only
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - only returns results from Ensembl (excludes PDB, UniProt, and
      NCBI results).
    inputBinding:
      position: 102
      prefix: --ensembl_only
  - id: expand
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - gget info now always returns all available information.
    inputBinding:
      position: 102
      prefix: --expand
  - id: id_deprecated
    type:
      - 'null'
      - type: array
        items: string
    doc: DEPRECATED - use positional argument instead. One or more Ensembl, WormBase
      or FlyBase IDs).
    inputBinding:
      position: 102
      prefix: --ens_ids
  - id: json
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - json is now the default output format (convert to csv using
      flag [--csv]).
    inputBinding:
      position: 102
      prefix: --json
  - id: ncbi
    type:
      - 'null'
      - boolean
    doc: TURN OFF results from NCBI database.
    inputBinding:
      position: 102
      prefix: --ncbi
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Also returns PDB IDs (might increase run time).
    inputBinding:
      position: 102
      prefix: --pdb
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: uniprot
    type:
      - 'null'
      - boolean
    doc: TURN OFF results from UniProt database.
    inputBinding:
      position: 102
      prefix: --uniprot
  - id: out_path
    type: string
    default: results.json
    doc: Path to file the results will be saved as, e.g. path/to/directory/results.json.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Gene and transcript metadata (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
