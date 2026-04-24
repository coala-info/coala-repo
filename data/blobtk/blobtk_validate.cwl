cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtk
  - validate
label: blobtk_validate
doc: "Validate BlobToolKit and GenomeHubs files.\n\nTool homepage: https://github.com/genomehubs/blobtk"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: genomehubs_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to match to taxIDs - Experimental
    inputBinding:
      position: 101
      prefix: --genomehubs_files
  - id: name_classes
    type:
      - 'null'
      - string
    doc: List of name_classes to use during taxon lookup
    inputBinding:
      position: 101
      prefix: --name-classes
  - id: skip_tsv
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --skip-tsv
  - id: taxdump
    type:
      - 'null'
      - File
    doc: Path to backbone taxonomy file/directory
    inputBinding:
      position: 101
      prefix: --taxdump
  - id: taxonomy_format
    type:
      - 'null'
      - string
    doc: Format of taxonomy file
    inputBinding:
      position: 101
      prefix: --taxonomy-format
outputs:
  - id: schema
    type:
      - 'null'
      - File
    doc: Path to output JSON Schema file
    outputBinding:
      glob: $(inputs.schema)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
