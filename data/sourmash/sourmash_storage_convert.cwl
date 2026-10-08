cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- storage
- convert
label: sourmash_storage_convert
doc: 'Convert a sequence bloom tree (SBT) index to another storage backend.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: sbt
  type: File
  doc: Sequence bloom tree index (.sbt.json) to convert; it is rewritten in place to point to the new storage.
  inputBinding:
    position: 100
- id: backend
  type:
  - 'null'
  - string
  doc: Backend to convert to
  inputBinding:
    position: 1
    prefix: --backend
- id: storage_dir
  type:
  - 'null'
  - Directory
  doc: Storage directory of the index (the hidden .sbt.* folder written by sourmash index -F SBT); staged beside the index file.
outputs:
- id: converted_sbt
  type: File
  doc: The converted index file.
  outputBinding:
    glob: $(inputs.sbt.basename)
- id: new_storage
  type:
    type: array
    items: File
  doc: New storage file (for example the zip file named in the backend).
  outputBinding:
    glob:
    - '*.zip'
    - '*.tar*'
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.sbt)
    writable: true
  - $(inputs.storage_dir)
