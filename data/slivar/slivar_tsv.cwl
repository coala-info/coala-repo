cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slivar
  - tsv
label: slivar_tsv
doc: "convert filtered VCF to tab-separated-value spreadsheet for final filtering\n\
  \nTool homepage: https://github.com/brentp/slivar"
inputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: input VCF
    inputBinding:
      position: 1
  - id: csq_column
    type:
      - 'null'
      - type: array
        items: string
    doc: CSQ sub-field(s) to extract (in addition to gene, impact, transcript). 
      may be specified multiple times.
    inputBinding:
      position: 102
      prefix: --csq-column
  - id: csq_field
    type:
      - 'null'
      - string
    doc: INFO field containing the gene name and impact. Usually CSQ or BCSQ
    inputBinding:
      position: 102
      prefix: --csq-field
  - id: gene_description
    type:
      - 'null'
      - type: array
        items: File
    doc: tab-separated lookup of gene (column 1) to description (column 2) to 
      add to output. the gene is case-sensitive. can be specified multiple times
    inputBinding:
      position: 102
      prefix: --gene-description
  - id: impact_order
    type:
      - 'null'
      - File
    doc: ordering of impacts to override the default 
      (https://raw.githubusercontent.com/brentp/slivar/master/src/slivarpkg/default-order.txt)
    inputBinding:
      position: 102
      prefix: --impact-order
  - id: info_field
    type:
      - 'null'
      - type: array
        items: string
    doc: INFO field(s) that should be added to output (e.g. gnomad_popmax_af) 
      can also use 'ID' or 'QUAL' to report those variant fields.
    inputBinding:
      position: 102
      prefix: --info-field
  - id: ped
    type: File
    doc: required ped file describing the trios in the VCF
    inputBinding:
      position: 102
      prefix: --ped
  - id: sample_field
    type:
      - 'null'
      - type: array
        items: string
    doc: INFO field(s) that contains list of samples that have passed previous 
      filters. can be specified multiple times.
    inputBinding:
      position: 102
      prefix: --sample-field
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: path to output tab-separated file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
