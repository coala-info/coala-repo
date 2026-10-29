cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - databases
label: mmseqs2_databases
doc: 'List or download a public database (for example UniRef90, Pfam-A.seed, Resfinder) and
  convert it to an MMseqs2 database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: name
    type: string
    doc: Name of the database to download, for example Resfinder
    inputBinding:
      position: 1
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output sequence database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: tmp_dir
    type: string
    doc: Temporary directory (created by the tool)
    inputBinding:
      position: 3
  - id: tsv
    type:
      - 'null'
      - int
    doc: Return output in TSV format (0 or 1)
    inputBinding:
      position: 104
      prefix: --tsv
  - id: force_reuse
    type:
      - 'null'
      - int
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version changes (0 or
      1)
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: remove_tmp_files
    type:
      - 'null'
      - int
    doc: Delete temporary files (0 or 1)
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
