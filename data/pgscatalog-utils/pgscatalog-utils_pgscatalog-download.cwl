cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-download
label: pgscatalog-utils_pgscatalog-download
doc: "Download a set of scoring files from the PGS Catalog using PGS Scoring IDs,
  traits, or publication accessions.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs:
  - id: efo_direct
    type:
      - 'null'
      - boolean
    doc: Return only PGS tagged with exact EFO term (e.g. no PGS for 
      child/descendant terms in the ontology)
    inputBinding:
      position: 101
      prefix: --efo_direct
  - id: efo_terms
    type:
      - 'null'
      - type: array
        items: string
    doc: Traits described by an EFO term(s) (e.g. EFO_0004611)
    inputBinding:
      position: 101
      prefix: --efo
  - id: genome_build
    type:
      - 'null'
      - string
    doc: 'Download harmonized scores with positions in genome build: GRCh37 or GRCh38'
    inputBinding:
      position: 101
      prefix: --build
  - id: outdir
    type: Directory
    doc: Output directory to store downloaded files
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing Scoring File if a new version is available for 
      download on the FTP
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pgp_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: PGP publication ID(s) (e.g. PGP000007)
    inputBinding:
      position: 101
      prefix: --pgp
  - id: pgs_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: PGS Catalog ID(s) (e.g. PGS000001)
    inputBinding:
      position: 101
      prefix: --pgs
  - id: user_agent
    type:
      - 'null'
      - string
    doc: Provide custom user agent when querying PGS Catalog API
    inputBinding:
      position: 101
      prefix: --user_agent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-download.out
