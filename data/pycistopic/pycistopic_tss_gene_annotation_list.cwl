cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pycistopic
  - tss
  - gene_annotation_list
label: pycistopic_tss_gene_annotation_list
doc: "Get list of all Ensembl BioMart gene annotation names.\n\nTool homepage: https://github.com/aertslab/pycisTopic"
inputs:
  - id: filter
    type:
      - 'null'
      - string
    doc: "Only keep list of Ensembl BioMart gene annotation names that contain specified string."
    inputBinding:
      position: 1
      prefix: -f
  - id: biomart_host
    type:
      - 'null'
      - string
    doc: "BioMart host URL to use. Default: http://www.ensembl.org."
    inputBinding:
      position: 1
      prefix: -s
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Disable caching of requests to Ensembl BioMart server.
    inputBinding:
      position: 1
      prefix: --no-cache
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
stdout: pycistopic_tss_gene_annotation_list.out
