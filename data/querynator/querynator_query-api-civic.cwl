cwlVersion: v1.2
class: CommandLineTool
baseCommand: querynator query-api-civic
label: querynator_query-api-civic
doc: "Query the Civic API for variants in a VCF file.\n\nTool homepage: https://github.com/qbic-pipelines/querynator"
inputs:
  - id: cancer
    type:
      - 'null'
      - string
    doc: the cancer DOID (id or name) to be searched.
    inputBinding:
      position: 101
      prefix: --cancer
  - id: filter_evidence
    type:
      - 'null'
      - string
    doc: "Key-Value pairs to filter the evidence items. Example: 'type=Predictive'"
    inputBinding:
      position: 101
      prefix: --filter_evidence
  - id: filter_vep
    type:
      - 'null'
      - boolean
    doc: if set, filters out synoymous and low impact variants based on VEP 
      annotation
    inputBinding:
      position: 101
      prefix: --filter_vep
  - id: genome
    type: string
    doc: Please enter the reference genome version
    inputBinding:
      position: 101
      prefix: --genome
  - id: outdir
    type: Directory
    doc: i.e. sample name. Directory in which results will be stored.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: vcf_file
    type: File
    doc: Please provide the path to a Variant Call Format (VCF) file (Version 
      4.2)
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
stdout: querynator_query-api-civic.out
