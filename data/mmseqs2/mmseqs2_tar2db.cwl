cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - tar2db
label: mmseqs2_tar2db
doc: 'Convert the content of tar archives into a database, one entry per file.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: tar_files
    type:
      type: array
      items: File
    doc: Input tar archives (optionally gzip compressed)
    inputBinding:
      position: 1
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: output_dbtype
    type:
      - 'null'
      - int
    doc: 'Set database type for resulting database: Amino acid sequences 0, Nucl. seq. 1,
      Profiles 2, Alignment result 5, Clustering result 6, Prefiltering result 7, Taxonomy
      result 8, Indexed database 9, cA3M MSAs 10, FASTA or A3M MSAs 11, Generic database 12,
      Omit dbtype file 13, Bi-directional prefiltering result 14, Offsetted headers 15'
    inputBinding:
      position: 104
      prefix: --output-dbtype
  - id: tar_include
    type:
      - 'null'
      - string
    doc: Include file names based on this regex
    inputBinding:
      position: 104
      prefix: --tar-include
  - id: tar_exclude
    type:
      - 'null'
      - string
    doc: Exclude file names based on this regex
    inputBinding:
      position: 104
      prefix: --tar-exclude
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
    doc: Directory holding the output database files
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
