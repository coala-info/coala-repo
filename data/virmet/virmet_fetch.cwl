cwlVersion: v1.2
class: CommandLineTool
baseCommand: virmet fetch
label: virmet_fetch
doc: "Fetch viral, human, bacterial, fungal, or bovine databases.\n\nTool homepage:
  https://github.com/medvir/VirMet"
inputs:
  - id: bact_fungal
    type:
      - 'null'
      - boolean
    doc: bacterial and fungal(RefSeq)
    inputBinding:
      position: 101
      prefix: --bact_fungal
  - id: bovine
    type:
      - 'null'
      - boolean
    doc: bovine (Bos taurus)
    inputBinding:
      position: 101
      prefix: --bovine
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: path to store the new Virmet database
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: human
    type:
      - 'null'
      - boolean
    doc: human
    inputBinding:
      position: 101
      prefix: --human
  - id: no_db_compression
    type:
      - 'null'
      - boolean
    doc: do not compress the viral database
    inputBinding:
      position: 101
      prefix: --no_db_compression
  - id: viral
    type:
      - 'null'
      - string
    doc: viral [nucleic acids/proteins]
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
stdout: virmet_fetch.out
