cwlVersion: v1.2
class: CommandLineTool
baseCommand: querynator query-api-cgi
label: querynator_query-api-cgi
doc: "Query the CGI API\n\nTool homepage: https://github.com/qbic-pipelines/querynator"
inputs:
  - id: cancer
    type: string
    doc: Please enter the cancer type to be searched. You must use quotation 
      marks.
    inputBinding:
      position: 101
      prefix: --cancer
  - id: cnas
    type:
      - 'null'
      - File
    doc: 'Please provide the path to the copy number alterations file:'
    inputBinding:
      position: 101
      prefix: --cnas
  - id: email
    type:
      - 'null'
      - string
    doc: Please provide your user email address for CGI
    inputBinding:
      position: 101
      prefix: --email
  - id: filter_vep
    type:
      - 'null'
      - boolean
    doc: If set, filters out synoymous and low impact variants based on VEP 
      annotation
    inputBinding:
      position: 101
      prefix: --filter_vep
  - id: genome
    type: string
    doc: Please enter the genome version
    inputBinding:
      position: 101
      prefix: --genome
  - id: mutations
    type:
      - 'null'
      - File
    doc: 'Please provide the path to the PASS filtered variant file (vcf,tsv,gtf,hgvs):
      See more info here: https://www.cancergenomeinterpreter.org/faq#q22'
    inputBinding:
      position: 101
      prefix: --mutations
  - id: outdir
    type: string
    doc: i.e. sample name. Directory in which results will be stored.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: token
    type: string
    doc: Please provide your token for CGI database
    inputBinding:
      position: 101
      prefix: --token
  - id: translocations
    type:
      - 'null'
      - File
    doc: 'Please provide the path to the file containing translocations:'
    inputBinding:
      position: 101
      prefix: --translocations
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
stdout: querynator_query-api-cgi.out
