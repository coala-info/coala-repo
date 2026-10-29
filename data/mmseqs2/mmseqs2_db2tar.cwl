cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - db2tar
label: mmseqs2_db2tar
doc: 'Archive the files of a database into a tar file.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: input_db
    type: Directory
    doc: Input database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.input_db_name)
  - id: input_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: tar_file
    type: string
    doc: Name of the output tar file (end in .tar.gz to compress)
    inputBinding:
      position: 2
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_tar
    type: File
    doc: Tar archive of the database
    outputBinding:
      glob: $(inputs.tar_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
