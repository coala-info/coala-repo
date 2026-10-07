cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - score-bed
label: consplice_constraint_score-bed
doc: "Add ConSplice scores to a bed variant file.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
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
  - id: bed_file
    type: File
    doc: 'The path to the 0-based variant file in bed format (tab-delimited with a header line).'
    inputBinding:
      position: 1
      prefix: --bed-file
  - id: score_type
    type: string
    doc: 'How to add the score: ''by-gene'' (by the gene name of the variant) or ''max'' (the max ConSplice score for the position).'
    inputBinding:
      position: 1
      prefix: --score-type
  - id: out_file
    type: string
    doc: 'The path and/or the name of the output file to create (.bed or .bed.gz is added when missing).'
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
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'The output file type: ''bed'' or ''bedgz''. Default = ''bed''.'
    inputBinding:
      position: 1
      prefix: --out-type
  - id: bed_chrom
    type:
      - 'null'
      - string
    doc: 'The name of the chromosome column in the bed file. Default = chrom.'
    inputBinding:
      position: 1
      prefix: --bed-chrom
  - id: bed_pos
    type:
      - 'null'
      - string
    doc: 'The name of the start position column in the bed file. Default = start.'
    inputBinding:
      position: 1
      prefix: --bed-pos
  - id: bed_gene_name
    type:
      - 'null'
      - string
    doc: 'The name of the gene name/symbol column in the bed file. Default = gene_name.'
    inputBinding:
      position: 1
      prefix: --bed-gene-name
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
    doc: 'The scored variant bed file.'
    outputBinding:
      glob: $(inputs.out_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
