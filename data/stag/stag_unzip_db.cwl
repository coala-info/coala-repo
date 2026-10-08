cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- unzip_db
label: stag_unzip_db
doc: 'Create a directory with the content of a STAG database.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: database
  type: File
  doc: database created with create_db or train
  inputBinding:
    position: 1
    prefix: -d
- id: dir_out
  type: string
  doc: create a dir with the unzipped database
  inputBinding:
    position: 1
    prefix: -o
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
- id: dir_out_result
  type: Directory
  doc: create a dir with the unzipped database
  outputBinding:
    glob: $(inputs.dir_out)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
