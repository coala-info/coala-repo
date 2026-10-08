cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - opentargets
label: gget_opentargets
doc: 'Query the Open Targets Platform with a gene for associated drugs, diseases,
  tractability stats, pharmacogenetic responses, expression data, DepMap effects,
  and protein-protein interaction data.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: ens_id
    type: string
    doc: Ensembl gene ID, e.g. ENSG00000169194.
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
  - id: filter_anat_sys
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by anatomical system, e.g. 'nervous system'. Only valid for
      the 'expression' resource.
    inputBinding:
      position: 102
      prefix: --filter_anat_sys
  - id: filter_disease
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by disease ID, e.g. 'EFO_0000274'. Only valid for the 'drugs'
      resource.
    inputBinding:
      position: 102
      prefix: --filter_disease
  - id: filter_drug
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by drug ID, e.g. 'CHEMBL1743081'. Only valid for the 'pharmacogenetics'
      resource.
    inputBinding:
      position: 102
      prefix: --filter_drug
  - id: filter_gene_b
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by gene B ID, e.g. 'ENSG00000077238'. Only valid for the 'interactions'
      resource.
    inputBinding:
      position: 102
      prefix: --filter_gene_b
  - id: filter_organ
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by organ, e.g. 'brain'. Only valid for the 'expression' resource.
    inputBinding:
      position: 102
      prefix: --filter_organ
  - id: filter_protein_a
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by protein A ID, e.g. 'ENSP00000304915'. Only valid for the
      'interactions' resource.
    inputBinding:
      position: 102
      prefix: --filter_protein_a
  - id: filter_protein_b
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter results by protein B ID, e.g. 'ENSP00000379111'. Only valid for the
      'interactions' resource.
    inputBinding:
      position: 102
      prefix: --filter_protein_b
  - id: filter_tissue
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Filter results by tissue ID, e.g. ''UBERON_0000473''. Only valid for the
      following resources: ''expression'', ''depmap''.'
    inputBinding:
      position: 102
      prefix: --filter_tissue
  - id: limit
    type:
      - 'null'
      - int
    doc: 'Limits the number of results, e.g. 10 (default: None). Note: Not compatible
      with the ''tractability'' and ''depmap'' resources'
    inputBinding:
      position: 102
      prefix: --limit
  - id: or_logic
    type:
      - 'null'
      - boolean
    doc: Use OR instead of AND logic for multiple filter IDs.
    inputBinding:
      position: 102
      prefix: --or
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: resource
    type:
      - 'null'
      - string
    doc: 'Type of information to be returned: diseases (default), drugs, tractability,
      pharmacogenetics, expression, depmap or interactions.'
    inputBinding:
      position: 102
      prefix: --resource
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
    doc: Open Targets results (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
