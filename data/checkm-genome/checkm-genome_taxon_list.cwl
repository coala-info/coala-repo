cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - taxon_list
label: checkm-genome_taxon_list
doc: "List available taxonomic-specific marker sets.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: rank
    type:
      - 'null'
      - string
    doc: 'restrict list to specified taxonomic rank: ALL, life, domain, phylum, class,
      order, family, genus or species (default: ALL)'
    inputBinding:
      position: 101
      prefix: --rank
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: 'specify an alternative directory for temporary files'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_taxon_list.out
