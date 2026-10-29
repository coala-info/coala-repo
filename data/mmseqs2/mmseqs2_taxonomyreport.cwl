cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - taxonomyreport
label: mmseqs2_taxonomyreport
doc: 'Create a taxonomy report in Kraken or Krona format from a taxonomy result database.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: seq_tax_db
    type: Directory
    doc: Sequence database with taxonomy
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.seq_tax_db_name)
  - id: seq_tax_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: tax_result_db
    type: Directory
    doc: Taxonomy result database (or result or sequence database)
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.tax_result_db_name)
  - id: tax_result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: report_name
    type: string
    doc: Name of the output report file (or of the output Kraken database with --report-mode
      3)
    inputBinding:
      position: 3
  - id: report_mode
    type:
      - 'null'
      - int
    doc: 'Taxonomy report mode 0: Kraken 1: Krona 2: do not create a report (for workflows
      only) 3: Kraken per query database'
    inputBinding:
      position: 104
      prefix: --report-mode
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
  - id: output_report
    type:
      type: array
      items: File
    doc: The report (or the files of the Kraken database)
    outputBinding:
      glob: $(inputs.report_name)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
