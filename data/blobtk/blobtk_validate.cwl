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
        inputBinding:
          prefix: --genomehubs_files
    doc: Files to match to taxIDs - Experimental
    inputBinding:
      position: 101
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
      - Directory
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
  - id: genomehubs_support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files (TSV) and other YAML files named in the genomehubs_files YAML
      (file name, needs); staged next to the YAML so the names resolve
  - id: schema_path
    type:
      - 'null'
      - string
    doc: Path to output JSON Schema file (when set, only the schema is written)
    inputBinding:
      position: 102
      prefix: --schema
outputs:
  - id: schema
    type:
      - 'null'
      - File
    doc: Path to output JSON Schema file
    outputBinding:
      glob: $(inputs.schema_path)
  - id: validated
    type:
      - 'null'
      - Directory
    doc: Validated data files and updated YAML configs (written beside the YAML)
    outputBinding:
      glob: validated
  - id: exceptions
    type:
      - 'null'
      - Directory
    doc: Rows that failed validation (exceptions/exceptions.jsonl)
    outputBinding:
      glob: exceptions
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$((inputs.genomehubs_files || []).concat(inputs.genomehubs_support_files
      || []))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
