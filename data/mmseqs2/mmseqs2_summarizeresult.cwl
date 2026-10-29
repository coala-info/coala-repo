cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - summarizeresult
label: mmseqs2_summarizeresult
doc: 'Extract annotations from an alignment database, merging overlapping regions.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: alignment_db
    type: Directory
    doc: Alignment database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.alignment_db_name)
  - id: alignment_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_alignment_db_name
    type: string
    doc: Name (prefix) of the output alignment database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: a
    type:
      - 'null'
      - int
    doc: Add backtrace string (convert to alignments with mmseqs convertalis module) (0 or
      1)
    inputBinding:
      position: 104
      prefix: -a
  - id: c
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: overlap
    type:
      - 'null'
      - float
    doc: Maximum overlap of covered regions
    inputBinding:
      position: 104
      prefix: --overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
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
