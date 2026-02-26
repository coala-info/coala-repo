cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy_search
label: genomepy_search
doc: "Search for genomes that contain TERM in their name, description, accession (must
  start with GCA_ or GCF_) or taxonomy (start).\n\nSearch is case-insensitive, name/description
  search accepts multiple terms and regex.\n\nReturns the metadata of each found genome,
  including the availability of a gene annotation. For UCSC, up to 4 gene annotation
  styles are available: \"ncbiRefSeq\", \"refGene\", \"ensGene\", \"knownGene\" (respectively).
  Each with different naming schemes.\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs:
  - id: term
    type:
      - 'null'
      - type: array
        items: string
    doc: Term(s) to search for in genome name, description, accession, or 
      taxonomy.
    inputBinding:
      position: 1
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Exact matches only.
    inputBinding:
      position: 102
      prefix: --exact
  - id: provider
    type:
      - 'null'
      - string
    doc: Only search this provider.
    inputBinding:
      position: 102
      prefix: --provider
  - id: size
    type:
      - 'null'
      - boolean
    doc: Show absolute genome size.
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy_search.out
