cwlVersion: v1.2
class: CommandLineTool
baseCommand: codan.py
label: codan_codan.py
doc: "CodAn: Coding Regions Annotator for transcripts using deep learning and BLAST.\n\
  \nTool homepage: https://github.com/pedronachtigall/CodAn"
inputs:
  - id: blastdb
    type:
      - 'null'
      - string
    doc: Optional - path to blastDB of known protein sequences, 
      /path/to/blast/DB/DB_name
    inputBinding:
      position: 101
      prefix: --blastdb
  - id: cpu
    type:
      - 'null'
      - int
    doc: Optional - number of threads to be used
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: hsp
    type:
      - 'null'
      - int
    doc: Optional - used in the "-qcov_hsp_perc" option of blastx
    default: 80
    inputBinding:
      position: 101
      prefix: --HSP
  - id: model
    type: Directory
    doc: Mandatory - path to model, /path/to/model
    inputBinding:
      position: 101
      prefix: --model
  - id: strand
    type:
      - 'null'
      - string
    doc: Optional - strand of sequence to predict genes (plus, minus or both)
    default: plus
    inputBinding:
      position: 101
      prefix: --strand
  - id: transcripts
    type: File
    doc: Mandatory - input transcripts file (FASTA format), 
      /path/to/transcripts.fa
    inputBinding:
      position: 101
      prefix: --transcripts
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Optional - path to output folder, /path/to/output/folder/ if not 
      declared, it will be created at the transcripts input folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codan:1.2--hdfd78af_1
