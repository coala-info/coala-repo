cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictProductivity
label: flair_predictProductivity
doc: 'Predict the open reading frames and productivity of isoforms in bed12 format.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_isoforms
    type: File
    doc: Input collapsed isoforms in bed12 format
    inputBinding:
      position: 1
      prefix: --input_isoforms
  - id: gtf
    type: File
    doc: Gencode annotation file
    inputBinding:
      position: 1
      prefix: --gtf
  - id: genome_fasta
    type: File
    doc: FASTA file containing sequences
    inputBinding:
      position: 1
      prefix: --genome_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: output
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 1
      prefix: --output
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not display progress
    inputBinding:
      position: 1
      prefix: --quiet
  - id: append_column
    type:
      - 'null'
      - boolean
    doc: Append the prediction as an additional column in the file
    inputBinding:
      position: 1
      prefix: --append_column
  - id: first_tis
    type:
      - 'null'
      - boolean
    doc: Define ORFs by the first annotated TIS
    inputBinding:
      position: 1
      prefix: --firstTIS
  - id: longest_orf
    type:
      - 'null'
      - boolean
    doc: Define ORFs by the longest open reading frame
    inputBinding:
      position: 1
      prefix: --longestORF
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Prediction files written with the output prefix
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
