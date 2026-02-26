cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukfinder long_seqs
label: eukfinder_long_seqs
doc: "Finds long sequences in a given file and searches them against a database.\n\
  \nTool homepage: https://github.com/RogerLab/Eukfinder"
inputs:
  - id: cdb
    type:
      - 'null'
      - Directory
    doc: path to centrifuge database
    inputBinding:
      position: 101
      prefix: --centrifuge-database
  - id: cov
    type:
      - 'null'
      - float
    doc: percentage coverage for plast searches
    inputBinding:
      position: 101
      prefix: --coverage
  - id: e_value
    type:
      - 'null'
      - float
    doc: threshold for plast searches
    inputBinding:
      position: 101
      prefix: --e-value
  - id: long_seqs
    type: File
    doc: long sequences file
    inputBinding:
      position: 101
      prefix: --long-seqs
  - id: mhlen
    type: int
    doc: minimum hit length
    inputBinding:
      position: 101
      prefix: --min-hit-length
  - id: number_of_chunks
    type:
      - 'null'
      - int
    doc: Number of chunks to split a file
    inputBinding:
      position: 101
      prefix: --number-of-chunks
  - id: number_of_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --number-of-threads
  - id: out_name
    type: string
    doc: output file basename
    inputBinding:
      position: 101
      prefix: --out_name
  - id: pid
    type:
      - 'null'
      - float
    doc: percentage identity for plast searches
    inputBinding:
      position: 101
      prefix: --percent_id
  - id: plast_database
    type:
      - 'null'
      - Directory
    doc: path to plast database
    inputBinding:
      position: 101
      prefix: --plast-database
  - id: plast_id_map
    type:
      - 'null'
      - File
    doc: path to taxonomy map for plast database
    inputBinding:
      position: 101
      prefix: --plast-id-map
  - id: taxonomy_update
    type:
      - 'null'
      - boolean
    doc: Set to True the first time the program is used. Otherwise set to False
    inputBinding:
      position: 101
      prefix: --taxonomy-update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
stdout: eukfinder_long_seqs.out
