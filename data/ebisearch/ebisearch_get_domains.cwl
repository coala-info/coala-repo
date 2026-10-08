cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ebisearch
  - get_domains
label: ebisearch_get_domains
doc: "Return the list of domains in EBI\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: file_path
    type:
      - 'null'
      - string
    doc: File to export the domain information (optional)
    inputBinding:
      position: 101
      prefix: --file
outputs:
  - id: file
    type:
      - 'null'
      - File
    doc: Exported domain information
    outputBinding:
      glob: $(inputs.file_path)
  - id: stdout
    type: stdout
    doc: Domain list printed to standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_get_domains.out
