cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - cellxgene
label: gget_cellxgene
doc: 'Query data from CZ CELLxGENE Discover (https://cellxgene.cziscience.com/).


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: assay
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of assay(s).
    inputBinding:
      position: 102
      prefix: --assay
  - id: assay_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of assay ontology term ID(s).
    inputBinding:
      position: 102
      prefix: --assay_ontology_term_id
  - id: census_version
    type:
      - 'null'
      - string
    doc: 'Census version, e.g. ''2023-05-15'' or ''latest'' or ''stable''. (default:
      stable)'
    inputBinding:
      position: 102
      prefix: --census_version
  - id: cell_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of cell_type(s), e.g. 'mucus secreting cell'
      'neuroendocrine cell'
    inputBinding:
      position: 102
      prefix: --cell_type
  - id: cell_type_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of celltype ontology term ID(s).
    inputBinding:
      position: 102
      prefix: --cell_type_ontology_term_id
  - id: column_names
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of metadata columns to return (stored in .obs). For more options see:
      https://api.cellxgene.cziscience.com/curation/ui/#/ -> Schemas -> dataset (default:
      [''dataset_id'', ''assay'', ''suspension_type'', ''sex'', ''tissue_general'',
      ''tissue'', ''cell_type''])'
    inputBinding:
      position: 102
      prefix: --column_names
  - id: dataset_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of CELLxGENE dataset ID(s).
    inputBinding:
      position: 102
      prefix: --dataset_id
  - id: development_stage
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of development_stage(s).
    inputBinding:
      position: 102
      prefix: --development_stage
  - id: development_stage_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of development stage ontology term ID(s).
    inputBinding:
      position: 102
      prefix: --development_stage_ontology_term_id
  - id: disease
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of disease(s).
    inputBinding:
      position: 102
      prefix: --disease
  - id: disease_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of disease ontology term ID(s).
    inputBinding:
      position: 102
      prefix: --disease_ontology_term_id
  - id: donor_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of donor ID(s).
    inputBinding:
      position: 102
      prefix: --donor_id
  - id: ensembl
    type:
      - 'null'
      - boolean
    doc: Use this flag when genes are provided as Ensembl IDs.
    inputBinding:
      position: 102
      prefix: --ensembl
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Str or space-separated list of gene name(s) or Ensembl ID(s), e.g. ACE2
      SLC5A1 or ENSG00000130234 ENSG00000100170. NOTE: Set ensembl=True when providing
      Ensembl ID(s) instead of gene name(s).'
    inputBinding:
      position: 102
      prefix: --gene
  - id: include_secondary
    type:
      - 'null'
      - boolean
    doc: Do not restrict results to the canonical instance of the cellular observation.
    inputBinding:
      position: 102
      prefix: --include_secondary
  - id: meta_only
    type:
      - 'null'
      - boolean
    doc: Only returns metadata dataframe (corresponds to AnnData.obs).
    inputBinding:
      position: 102
      prefix: --meta_only
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: self_reported_ethnicity
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of self reported ethnicity.
    inputBinding:
      position: 102
      prefix: --self_reported_ethnicity
  - id: self_reported_ethnicity_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of self reported ethnicity ontology ID(s).
    inputBinding:
      position: 102
      prefix: --self_reported_ethnicity_ontology_term_id
  - id: sex
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of sex(es).
    inputBinding:
      position: 102
      prefix: --sex
  - id: sex_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of sex ontology ID(s).
    inputBinding:
      position: 102
      prefix: --sex_ontology_term_id
  - id: species
    type:
      - 'null'
      - string
    doc: 'Choice of ''homo_sapiens'' or ''mus_musculus''. (default: homo_sapiens)'
    inputBinding:
      position: 102
      prefix: --species
  - id: suspension_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of suspension type(s).
    inputBinding:
      position: 102
      prefix: --suspension_type
  - id: tissue
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of tissue(s), e.g. lung blood
    inputBinding:
      position: 102
      prefix: --tissue
  - id: tissue_general
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Str or space-separated list of high-level tissue label(s). Also see: https://github.com/chanzuckerberg/single-cell-data-portal/blob/9b94ccb0a2e0a8f6182b213aa4852c491f6f6aff/backend/wmg/data/tissue_mapper.py'
    inputBinding:
      position: 102
      prefix: --tissue_general
  - id: tissue_general_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Str or space-separated list of high-level tissue UBERON ID(s). Also see:
      https://github.com/chanzuckerberg/single-cell-data-portal/blob/9b94ccb0a2e0a8f6182b213aa4852c491f6f6aff/backend/wmg/data/tissue_mapper.py'
    inputBinding:
      position: 102
      prefix: --tissue_general_ontology_term_id
  - id: tissue_ontology_term_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Str or space-separated list of tissue ontology term ID(s).
    inputBinding:
      position: 102
      prefix: --tissue_ontology_term_id
  - id: out_path
    type: string
    default: cellxgene.h5ad
    doc: Path to save the generated AnnData .h5ad file (or .csv with --meta_only).
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: File
    doc: AnnData .h5ad file, or .csv metadata with --meta_only.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
