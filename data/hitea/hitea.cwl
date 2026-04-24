cwlVersion: v1.2
class: CommandLineTool
baseCommand: hitea
label: hitea
doc: "No input provided\n\nTool homepage: https://github.com/parklab/HiTea"
inputs:
  - id: anchor_mapq
    type:
      - 'null'
      - int
    doc: 'Mapping quality threshold for repeat anchored mate on the reference genome
      (default: 28)'
    inputBinding:
      position: 101
      prefix: -q
  - id: annotation
    type:
      - 'null'
      - File
    doc: reference-genome copies for TE-family members
    inputBinding:
      position: 101
      prefix: -a
  - id: clip
    type:
      - 'null'
      - int
    doc: 'Minimum clip length for detecting insertion (should be >=13bp) (default:
      20)'
    inputBinding:
      position: 101
      prefix: -s
  - id: enzyme
    type:
      - 'null'
      - string
    doc: "Restriction endunuclease used for the assay (default: '', available:MboI,DpnII,HindIII,Arima,NcoI,NotI)"
    inputBinding:
      position: 101
      prefix: -e
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Genome build to be used (default:hg38, available: hg19)'
    inputBinding:
      position: 101
      prefix: -g
  - id: index
    type:
      - 'null'
      - File
    doc: fasta format file for TE-consensus sequences
    inputBinding:
      position: 101
      prefix: -n
  - id: inputs
    type: File
    doc: Input file in pairsam format or unsorted-lossless bam format
    inputBinding:
      position: 101
      prefix: -i
  - id: outprefix
    type:
      - 'null'
      - string
    doc: 'Output prefix while generating report files (default: project)'
    inputBinding:
      position: 101
      prefix: -o
  - id: polymorphic_index
    type:
      - 'null'
      - File
    doc: fasta format file for Polymorphic sequences (header should be 
      Family~name format
    inputBinding:
      position: 101
      prefix: -p
  - id: remap
    type:
      - 'null'
      - boolean
    doc: whether to remap unmapped clipped reads to the polymoprhic sequences 
      (default:F)
    inputBinding:
      position: 101
      prefix: -r
  - id: repbase
    type:
      - 'null'
      - File
    doc: fasta format file for Repbase subfamily sequences
    inputBinding:
      position: 101
      prefix: -b
  - id: wgs
    type:
      - 'null'
      - boolean
    doc: whether the file is a WGS experiment (default:F)
    inputBinding:
      position: 101
      prefix: -x
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Working directory where the files are to be written
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hitea:0.1.5--hdfd78af_1
stdout: hitea.out
