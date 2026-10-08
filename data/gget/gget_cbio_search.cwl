cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - cbio
  - search
label: gget_cbio_search
doc: 'Search for genes in cBioPortal.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: keywords
    type:
      type: array
      items: string
    doc: Keywords to search for in cBioPortal.
    inputBinding:
      position: 1
outputs:
  - id: out
    type: stdout
    doc: Search results printed by gget cbio search.
stdout: cbio_search.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
