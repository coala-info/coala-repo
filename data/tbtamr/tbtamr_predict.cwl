cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbtamr predict
label: tbtamr_predict
doc: "Predict resistance profiles and lineages from VCF files.\n\nTool homepage: https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: barcode
    type:
      - 'null'
      - File
    doc: Barcode to use for lineage calling and speciation.
    default: 
      /usr/local/lib/python3.13/site-packages/tbtamr/db/tbtamr.barcode.bed
    inputBinding:
      position: 101
      prefix: --barcode
  - id: call_lineage
    type:
      - 'null'
      - boolean
    doc: Use pathogen profiler to call lineage
    default: false
    inputBinding:
      position: 101
      prefix: --call_lineage
  - id: cascade
    type:
      - 'null'
      - boolean
    doc: If you would like to apply cascade reporting structure.
    default: false
    inputBinding:
      position: 101
      prefix: --cascade
  - id: catalog
    type:
      - 'null'
      - File
    doc: csv variant catalog
    default: 
      /usr/local/lib/python3.13/site-packages/tbtamr/db/who_v2_catalog.csv
    inputBinding:
      position: 101
      prefix: --catalog
  - id: catalog_config
    type:
      - 'null'
      - File
    doc: json file indicating the relevant column settings for interpretation of
      the catalog file.
    default: 
      /usr/local/lib/python3.13/site-packages/tbtamr/configs/db_config.json
    inputBinding:
      position: 101
      prefix: --catalog_config
  - id: classification_criteria
    type:
      - 'null'
      - File
    doc: csv file with rules for predicting resistance profiles from genomic 
      data.
    default: 
      /usr/local/lib/python3.13/site-packages/tbtamr/configs/classification_criteria.csv
    inputBinding:
      position: 101
      prefix: --classification_criteria
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force replace an existing folder.
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: interpretation_criteria
    type:
      - 'null'
      - File
    doc: csv file with rules for predicting resistance profiles from genomic 
      data.
    default: 
      /usr/local/lib/python3.13/site-packages/tbtamr/configs/interpretation_criteria.csv
    inputBinding:
      position: 101
      prefix: --interpretation_criteria
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference file to use for calling lineage.
    default: /usr/local/lib/python3.13/site-packages/tbtamr/db/tbtamr.fasta
    inputBinding:
      position: 101
      prefix: --reference_file
  - id: seq_id
    type:
      - 'null'
      - string
    doc: Sequence name.
    default: tbtamr
    inputBinding:
      position: 101
      prefix: --seq_id
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: temp directory to use
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file generated using the H37rV v3 reference genome
    default: ''
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr_predict.out
