cwlVersion: v1.2
class: CommandLineTool
baseCommand: virmet update
label: virmet_update
doc: "Update the Virmet database.\n\nTool homepage: https://github.com/medvir/VirMet"
inputs:
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: path to store the updated Virmet database
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: no_db_compression
    type:
      - 'null'
      - boolean
    doc: do not compress the viral database
    inputBinding:
      position: 101
      prefix: --no_db_compression
  - id: picked
    type:
      - 'null'
      - File
    doc: file with additional sequences, one GI per line
    inputBinding:
      position: 101
      prefix: --picked
  - id: update_min_date
    type:
      - 'null'
      - string
    doc: "update viral [n]ucleic/[p]rotein with sequences\n                      \
      \  produced after the date YYYY/MM/DD"
    inputBinding:
      position: 101
      prefix: --update_min_date
  - id: viral
    type:
      - 'null'
      - string
    doc: update viral [n]ucleic/[p]rotein
    inputBinding:
      position: 101
      prefix: --viral
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
stdout: virmet_update.out
