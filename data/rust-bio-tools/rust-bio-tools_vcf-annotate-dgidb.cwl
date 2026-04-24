cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - vcf-annotate-dgidb
label: rust-bio-tools_vcf-annotate-dgidb
doc: "Looks for interacting drugs in DGIdb and annotates them for every gene in every
  record.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: vcf
    type: File
    doc: VCF/BCF file to be extended by dgidb drug entries
    inputBinding:
      position: 1
  - id: api_path
    type:
      - 'null'
      - string
    doc: Url prefix for requesting interaction drugs by gene names
    inputBinding:
      position: 102
      prefix: --api-path
  - id: datasources
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of data sources included in query. If omitted all sources are 
      considered. A list of all sources can be found at 
      http://dgidb.org/api/v2/interaction_sources.json
    inputBinding:
      position: 102
      prefix: --datasources
  - id: field
    type:
      - 'null'
      - string
    doc: Info field name to be used for annotation
    inputBinding:
      position: 102
      prefix: --field
  - id: genes_per_request
    type:
      - 'null'
      - int
    doc: Number of genes to submit per api request. A lower value increases the 
      number of api requests in return. Too many requests could be rejected by 
      the DGIdb server
    inputBinding:
      position: 102
      prefix: --genes-per-request
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_vcf-annotate-dgidb.out
