cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - tsv2db
label: mmseqs2_tsv2db
doc: 'Convert a tab-separated file into a database of any type.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: tsv_file
    type: File
    doc: Input tab-separated file
    inputBinding:
      position: 1
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: add_self_matches
    type:
      - 'null'
      - int
    doc: Artificially add entries of queries with themselves (for clustering) (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-self-matches
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
