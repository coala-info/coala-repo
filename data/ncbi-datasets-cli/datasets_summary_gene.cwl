cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - summary
  - gene
label: datasets_summary_gene
doc: Print a data report containing gene metadata. The data report is returned 
  in JSON format.
inputs:
  - id: subcommand
    type: string
    doc: The specific search method (gene-id, symbol, accession, or taxon)
    inputBinding:
      position: 1
  - id: query
    type: string
    doc: The search term (e.g., gene ID, symbol, or accession)
    inputBinding:
      position: 2
  - id: as_json_lines
    type:
      - 'null'
      - boolean
    doc: Stream results as newline delimited JSON-Lines
    inputBinding:
      position: 103
      prefix: --as-json-lines
  - id: limit
    type:
      - 'null'
      - string
    doc: Limit the number of gene summaries returned (all or a number)
    inputBinding:
      position: 103
      prefix: --limit
  - id: report
    type:
      - 'null'
      - string
    doc: 'Choose the output type: gene, product, or ids_only'
    inputBinding:
      position: 103
      prefix: --report
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify an NCBI API key
    inputBinding:
      position: 103
      prefix: --api-key
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit debugging info
    inputBinding:
      position: 103
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
stdout: datasets_summary_gene.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
