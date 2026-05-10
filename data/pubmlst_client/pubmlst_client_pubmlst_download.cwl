cwlVersion: v1.2
class: CommandLineTool
baseCommand: pubmlst_download
label: pubmlst_client_pubmlst_download
doc: "Download schemes from PubMLST API\n\nTool homepage: https://github.com/Public-Health-Bioinformatics/pubmlst_client"
inputs:
  - id: base_url
    type:
      - 'null'
      - string
    doc: 'Base URL for the API. Suggested values are: http://rest.pubmlst.org/db (default),
      https://bigsdb.pasteur.fr/api/db'
    inputBinding:
      position: 101
      prefix: --base-url
  - id: scheme_id
    type:
      - 'null'
      - string
    doc: scheme id
    inputBinding:
      position: 101
      prefix: --scheme_id
  - id: scheme_name
    type: string
    doc: scheme name
    inputBinding:
      position: 101
      prefix: --scheme_name
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pubmlst_client:0.2.0--py_0
