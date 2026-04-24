cwlVersion: v1.2
class: CommandLineTool
baseCommand: phabox2
label: phabox_phabox2
doc: "PhaBOX v2.1.13\n\nTool homepage: https://github.com/KennthShang/PhaBOX"
inputs:
  - id: aai
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --aai
  - id: ani
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --ani
  - id: bfolder
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 101
      prefix: --bfolder
  - id: blast
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --blast
  - id: contigs
    type: File
    doc: Path of the input FASTA file (required)
    inputBinding:
      position: 101
      prefix: --contigs
  - id: cov
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --cov
  - id: dbdir
    type: Directory
    doc: Path of downloaded phabox2 database directory (required)
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: draw
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --draw
  - id: len
    type:
      - 'null'
      - int
    doc: "Filter the length of contigs || default: 3000\n    Contigs with length smaller
      than this value will not proceed"
    inputBinding:
      position: 101
      prefix: --len
  - id: magonly
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --magonly
  - id: marker
    type:
      - 'null'
      - type: array
        items: string
    inputBinding:
      position: 101
      prefix: --marker
  - id: midfolder
    type:
      - 'null'
      - Directory
    doc: "Midfolder for intermediate files. (optional)\n    This folder will be created
      within the --outpth to store intermediate files."
    inputBinding:
      position: 101
      prefix: --midfolder
  - id: mode
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --mode
  - id: pcov
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --pcov
  - id: pident
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --pident
  - id: proteins
    type:
      - 'null'
      - File
    doc: FASTA file of predicted proteins. (optional)
    inputBinding:
      position: 101
      prefix: --proteins
  - id: reject
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --reject
  - id: sensitive
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: share
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --share
  - id: skip
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --skip
  - id: task
    type:
      - 'null'
      - string
    doc: 'Select a program to run: end_to_end, phamer, phagcn, phatyp, cherry, phavip,
      contamination, votu, tree'
    inputBinding:
      position: 101
      prefix: --task
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: outpth
    type: Directory
    doc: "Rootpth for the output folder (required)\n    All the results, including
      intermediate files and final predictions, are stored in this folder."
    outputBinding:
      glob: $(inputs.outpth)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phabox:2.1.13--pyhdfd78af_1
