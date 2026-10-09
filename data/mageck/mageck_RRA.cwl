cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RRA
label: mageck_RRA
doc: "RRA - Robust Rank Aggreation v 0.5.9. Rank aggregation of sgRNA values by group
  (gene), the engine behind mageck test.\n\nTool homepage: http://mageck.sourceforge.net"
inputs:
  - id: input_file
    type: File
    doc: "Input data file. Format: <item id> <group id> <list id> <value> [<probability>]
      [<chosen>]"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file
    type: string
    doc: "Output file name. Format: <group id> <number of items in the group> <lo-value>
      <false discovery rate>"
    inputBinding:
      position: 101
      prefix: -o
  - id: max_percentile
    type:
      - 'null'
      - float
    doc: Maximum percentile. RRA only considers the items with percentile smaller
      than this parameter. Default=0.1
    inputBinding:
      position: 101
      prefix: -p
  - id: min_percentile
    type:
      - 'null'
      - float
    doc: Minimum percentile. RRA only considers the items with percentile greater
      than this parameter. Default=-1.0
    inputBinding:
      position: 101
      prefix: -P
  - id: control
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of control sgRNA names.
    inputBinding:
      position: 101
      prefix: --control
      itemSeparator: ','
  - id: permutation
    type:
      - 'null'
      - int
    doc: The number of rounds of permutation. Increase this value if the number
      of genes is small. Default 100.
    inputBinding:
      position: 101
      prefix: --permutation
  - id: no_permutation_by_group
    type:
      - 'null'
      - boolean
    doc: Perform permutation on all genes together instead of separately by their
      number of sgRNAs. Faster, but the p value estimation is accurate only if the
      number of sgRNAs per gene is approximately the same.
    inputBinding:
      position: 101
      prefix: --no-permutation-by-group
  - id: skip_gene
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --skip-gene
    doc: Genes to skip from doing permutation. Specify it multiple times if you need to skip more than 1 genes.
    inputBinding:
      position: 101
  - id: min_percentage_goodsgrna
    type:
      - 'null'
      - float
    doc: Filter genes that have too few percentage of 'good sgrnas', or sgrnas that
      fall below the -p threshold. Must be a number between 0-1. Default 0 (do not
      filter genes).
    inputBinding:
      position: 101
      prefix: --min-percentage-goodsgrna
  - id: min_number_goodsgrna
    type:
      - 'null'
      - int
    doc: Filter genes that have too few number of 'good sgrnas', or sgrnas that
      fall below the -p threshold. Must be an integer. Default 0 (do not filter
      genes).
    inputBinding:
      position: 101
      prefix: --min-number-goodsgrna
  - id: max_sgrnapergene_permutation
    type:
      - 'null'
      - int
    doc: Only permute genes by group if the number of sgRNAs per gene is smaller
      than this number. Must be an integer. Default 100.
    inputBinding:
      position: 101
      prefix: --max-sgrnapergene-permutation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - File
    doc: Gene-level RRA result
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck_RRA.out
