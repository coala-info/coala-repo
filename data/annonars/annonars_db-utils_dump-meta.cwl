cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- db-utils
- dump-meta
label: annonars_db-utils_dump-meta
doc: '"dump-meta" sub command: Print the metadata of a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_in
  type: Directory
  doc: Path to input directory
  inputBinding:
    position: 1
    prefix: --path-in
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Increase logging verbosity
  inputBinding:
    position: 1
    prefix: --verbose
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Decrease logging verbosity
  inputBinding:
    position: 1
    prefix: --quiet
outputs:
- id: meta
  type: stdout
  doc: Metadata of the RocksDB database
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
stdout: $(inputs.path_in.basename).meta.txt
