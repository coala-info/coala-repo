cwlVersion: v1.2
class: CommandLineTool
baseCommand: generax
label: generax
doc: "GeneRax 2.1.3\n\nTool homepage: https://github.com/benoitmorel/generax"
inputs:
  - id: do_not_reconcile
    type:
      - 'null'
      - boolean
    doc: Disable reconciliation
    inputBinding:
      position: 101
      prefix: --do-not-reconcile
  - id: duplication_rate
    type:
      - 'null'
      - float
    doc: duplication rate
    inputBinding:
      position: 101
      prefix: --dup-rate
  - id: families_information
    type: string
    doc: FAMILIES_INFORMATION
    inputBinding:
      position: 101
      prefix: --families
  - id: gene_search_strategy
    type:
      - 'null'
      - string
    doc: STRATEGY
    default: EVAL, SPR
    inputBinding:
      position: 101
      prefix: --geneSearchStrategy
  - id: loss_rate
    type:
      - 'null'
      - float
    doc: loss rate
    inputBinding:
      position: 101
      prefix: --loss-rate
  - id: max_spr_radius
    type:
      - 'null'
      - int
    doc: max SPR radius
    inputBinding:
      position: 101
      prefix: --max-spr-radius
  - id: output_prefix
    type: string
    doc: OUTPUT PREFIX
    inputBinding:
      position: 101
      prefix: --prefix
  - id: per_family_rates
    type:
      - 'null'
      - boolean
    doc: Enable per-family rates
    inputBinding:
      position: 101
      prefix: --per-family-rates
  - id: per_species_rates
    type:
      - 'null'
      - boolean
    doc: Enable per-species rates
    inputBinding:
      position: 101
      prefix: --per-species-rates
  - id: reconciliation_likelihood_weight
    type:
      - 'null'
      - float
    doc: reconciliation likelihood weight
    inputBinding:
      position: 101
      prefix: --rec-weight
  - id: reconciliation_model
    type:
      - 'null'
      - string
    doc: reconciliationModel
    default: UndatedDL, UndatedDTL, Auto
    inputBinding:
      position: 101
      prefix: --rec-model
  - id: reconciliation_samples
    type:
      - 'null'
      - int
    doc: number of samples
    inputBinding:
      position: 101
      prefix: --reconciliation-samples
  - id: seed
    type:
      - 'null'
      - int
    doc: seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: species_tree
    type: File
    doc: SPECIES TREE
    inputBinding:
      position: 101
      prefix: --species-tree
  - id: support_threshold
    type:
      - 'null'
      - float
    doc: threshold
    inputBinding:
      position: 101
      prefix: --support-threshold
  - id: transfer_rate
    type:
      - 'null'
      - float
    doc: transfer rate
    inputBinding:
      position: 101
      prefix: --transfer-rate
  - id: unrooted_gene_tree
    type:
      - 'null'
      - boolean
    doc: Enable unrooted gene tree output
    inputBinding:
      position: 101
      prefix: --unrooted-gene-tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/generax:2.1.3--hf316886_3
stdout: generax.out
