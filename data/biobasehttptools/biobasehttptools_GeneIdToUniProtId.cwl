cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneIdToUniProtId
label: biobasehttptools_GeneIdToUniProtId
doc: "Converts Ensembl gene IDs or NCBI locus tags to UniProt IDs.\n\nTool homepage:
  https://github.com/eggzilla/BiobaseHTTPTools"
inputs:
  - id: geneidfilepath
    type:
      - 'null'
      - File
    doc: "Path to file containing one Ensembl gene ids (or NCBI locus tags) per line,
      e.g b0001\nb0825"
    inputBinding:
      position: 101
      prefix: --geneidfilepath
  - id: geneids
    type:
      - 'null'
      - type: array
        items: string
    doc: Ensembl gene ids (or NCBI locus tags) comma separated, e.g b0001,b0825
    inputBinding:
      position: 101
      prefix: --geneids
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_GeneIdToUniProtId.out
