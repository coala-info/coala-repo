cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - taxon_set
label: checkm-genome_taxon_set
doc: "Generate taxonomic-specific marker set.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: rank
    type: string
    doc: 'taxonomic rank: life, domain, phylum, class, order, family, genus or
      species'
    inputBinding:
      position: 1
  - id: taxon
    type: string
    doc: 'taxon of interest'
    inputBinding:
      position: 2
  - id: marker_file
    type: string
    doc: 'output file describing taxonomic-specific marker set'
    inputBinding:
      position: 3
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: 'specify an alternative directory for temporary files'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: marker_file_out
    type: File
    doc: 'output file describing taxonomic-specific marker set'
    outputBinding:
      glob: $(inputs.marker_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
