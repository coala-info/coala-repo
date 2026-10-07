cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - score-txt
label: consplice_constraint_score-txt
doc: "Add ConSplice scores to a tab-delimited txt variant file.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: consplice_file
    type: File
    doc: 'The path to the 0-based ConSplice score file in bed format.'
    inputBinding:
      position: 1
      prefix: --consplice-file
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: txt_file
    type: File
    doc: 'The path to the 1-based variant file in txt format (tab-delimited with a header line).'
    inputBinding:
      position: 1
      prefix: --txt-file
  - id: score_type
    type: string
    doc: 'How to add the score: ''by-gene'' (by the gene name of the variant) or ''max'' (the max ConSplice score for the position).'
    inputBinding:
      position: 1
      prefix: --score-type
  - id: out_file
    type: string
    doc: 'The path and/or the name of the output file to create.'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: alt_gene_symbol
    type:
      - 'null'
      - File
    doc: 'A file with a header that maps canonical gene symbols to alternative gene symbols (required if score_type is ''by-gene'').'
    inputBinding:
      position: 1
      prefix: --alt-gene-symbol
  - id: txt_chrom
    type:
      - 'null'
      - string
    doc: 'The name of the chromosome column in the txt file. Default = chrom.'
    inputBinding:
      position: 1
      prefix: --txt-chrom
  - id: txt_pos
    type:
      - 'null'
      - string
    doc: 'The name of the position column in the txt file. Default = pos.'
    inputBinding:
      position: 1
      prefix: --txt-pos
  - id: txt_gene_name
    type:
      - 'null'
      - string
    doc: 'The name of the gene name/symbol column in the txt file. Default = gene_name.'
    inputBinding:
      position: 1
      prefix: --txt-gene-name
  - id: consplice_col
    type:
      - 'null'
      - string
    doc: 'The name of the ConSplice score column in the ConSplice file. Default = ConSplice_Percentile.'
    inputBinding:
      position: 1
      prefix: --consplice-col
  - id: out_consplice_col
    type:
      - 'null'
      - string
    doc: 'The name of the ConSplice score column to create. Default = ''ConSplice_score''.'
    inputBinding:
      position: 1
      prefix: --out-consplice-col
outputs:
  - id: output
    type: File
    doc: 'The output file.'
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
