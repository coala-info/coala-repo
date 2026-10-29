cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - convertmsa
label: mmseqs2_convertmsa
doc: 'Convert a Stockholm or Pfam multiple sequence alignment file to an MSA database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: msa_file
    type: File
    doc: Stockholm MSA file (optionally gzip)
    inputBinding:
      position: 1
  - id: output_msa_db_name
    type: string
    doc: Name (prefix) of the output MSA database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: identifier_field
    type:
      - 'null'
      - int
    doc: 'Field from STOCKHOLM comments for choosing the MSA identifier: 0: ID, 1: AC. If
      the respective comment does not exist, the name of the first sequence will become the
      identifier'
    inputBinding:
      position: 104
      prefix: --identifier-field
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
