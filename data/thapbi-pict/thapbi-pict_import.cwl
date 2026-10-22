cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - import
label: thapbi-pict_import
doc: "Load a FASTA file into a database. Supports several naming conventions for the FASTA titles (simple, ncbi, sintax, taxid, obitools).\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "One or more prepared FASTA filenames (or folders of `*.fasta`)."
    inputBinding:
      position: 101
      prefix: -i
  - id: database
    type: string
    doc: "Which database to write to (or create)."
    inputBinding:
      position: 101
      prefix: -d
  - id: existing_database
    type:
      - 'null'
      - File
    doc: "Optional existing database to add to; it is staged under the name given in database."
  - id: marker
    type:
      - 'null'
      - string
    doc: "Unique marker name for a barcode, e.g. ITS1, COI, 12S. Required unless DB has exactly one marker already defined in it."
    inputBinding:
      position: 101
      prefix: -k
  - id: left
    type:
      - 'null'
      - string
    doc: "Left primer sequence to record in DB for this marker. Can use IUPAC ambiguity codes."
    inputBinding:
      position: 101
      prefix: -l
  - id: right
    type:
      - 'null'
      - string
    doc: "Right primer sequence to record in the DB for this marker. Can use IUPAC ambiguity codes."
    inputBinding:
      position: 101
      prefix: -r
  - id: minlen
    type:
      - 'null'
      - int
    doc: "Minimum acceptable amplicon length for this import. Default 100 if marker not already defined."
    inputBinding:
      position: 101
      prefix: --minlen
  - id: maxlen
    type:
      - 'null'
      - int
    doc: "Maximum acceptable amplicon length for this import. Default 1000 if marker not already defined."
    inputBinding:
      position: 101
      prefix: --maxlen
  - id: name
    type:
      - 'null'
      - string
    doc: "Name to record for this data source (string)."
    inputBinding:
      position: 101
      prefix: -n
  - id: lax
    type:
      - 'null'
      - boolean
    doc: "Accept species names without pre-loaded taxonomy."
    inputBinding:
      position: 101
      prefix: -x
  - id: genus
    type:
      - 'null'
      - boolean
    doc: "Record at genus level only (and only validate at genus level, unless using -x / --lax)."
    inputBinding:
      position: 101
      prefix: -g
  - id: convention
    type:
      - 'null'
      - string
    doc: "Which naming convention does the FASTA file follow: simple, ncbi, sintax, taxid or obitools."
    inputBinding:
      position: 101
      prefix: -c
  - id: sep
    type:
      - 'null'
      - string
    doc: "FASTA description multi-entry separator character. Default none meaning assume single entries."
    inputBinding:
      position: 101
      prefix: -s
  - id: ignore_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more filename prefixes to ignore, default Undetermined_ unknown_"
    inputBinding:
      position: 101
      prefix: --ignore-prefixes
  - id: temp
    type:
      - 'null'
      - string
    doc: "Debug option. Specify an (ideally empty) directory to use for temporary files, which will not be deleted."
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: database_file
    type: File
    doc: "Marker database written"
    outputBinding:
      glob: $(inputs.database)
  - id: log
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.existing_database ? [{entryname: inputs.database, entry: inputs.existing_database, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_import.out
