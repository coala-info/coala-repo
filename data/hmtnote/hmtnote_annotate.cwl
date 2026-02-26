cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmtnote
  - annotate
label: hmtnote_annotate
doc: "Annotate a VCF file using data from HmtVar.\n\nTool homepage: https://github.com/robertopreste/hmtnote"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file to be annotated
    inputBinding:
      position: 1
  - id: basic
    type:
      - 'null'
      - boolean
    doc: Annotate VCF using basic information (locus, pathogenicity, etc.)
    default: false
    inputBinding:
      position: 102
      prefix: --basic
  - id: crossref
    type:
      - 'null'
      - boolean
    doc: Annotate VCF using cross-reference information (Clinvar and dbSNP IDs, 
      etc.)
    default: false
    inputBinding:
      position: 102
      prefix: --crossref
  - id: offline
    type:
      - 'null'
      - boolean
    doc: Annotate VCF using previously downloaded databases (offline mode)
    default: false
    inputBinding:
      position: 102
      prefix: --offline
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Annotate VCF using predictions information (from MutPred, Panther, 
      Polyphen and other resources)
    default: false
    inputBinding:
      position: 102
      prefix: --predict
  - id: variab
    type:
      - 'null'
      - boolean
    doc: Annotate VCF using variability information (nucleotide and aminoacid 
      variability, allele frequencies)
    default: false
    inputBinding:
      position: 102
      prefix: --variab
outputs:
  - id: output_vcf
    type: File
    doc: Output annotated VCF file
    outputBinding:
      glob: '*.out'
  - id: csv
    type:
      - 'null'
      - File
    doc: Produce an additional annotated CSV file
    outputBinding:
      glob: $(inputs.csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmtnote:0.7.2--pyhdfd78af_1
