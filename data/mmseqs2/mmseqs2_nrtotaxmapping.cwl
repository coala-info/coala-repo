cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - nrtotaxmapping
label: mmseqs2_nrtotaxmapping
doc: 'Create taxonomy mapping for NR database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: accession2taxid_files
    type:
      type: array
      items: File
    doc: accession2taxid files (NCBI prot.accession2taxid.gz style)
    inputBinding:
      position: 1
  - id: seq_db
    type: Directory
    doc: Sequence database of the NR sequences
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.seq_db_name)
  - id: seq_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_tsv_name
    type: string
    doc: Name of the output mapping file
    inputBinding:
      position: 3
  - id: names_dmp
    type: File
    doc: NCBI taxonomy names.dmp (the tool reads it from the working directory; the help does
      not say so)
  - id: nodes_dmp
    type: File
    doc: NCBI taxonomy nodes.dmp (read from the working directory)
  - id: merged_dmp
    type: File
    doc: NCBI taxonomy merged.dmp (read from the working directory)
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
  - id: output_tsv
    type: File
    doc: Tab-separated mapping of sequence keys to taxon identifiers
    outputBinding:
      glob: $(inputs.output_tsv_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: names.dmp
        entry: $(inputs.names_dmp)
      - entryname: nodes.dmp
        entry: $(inputs.nodes_dmp)
      - entryname: merged.dmp
        entry: $(inputs.merged_dmp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
