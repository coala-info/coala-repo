cwlVersion: v1.2
class: CommandLineTool
baseCommand: piler
label: piler
doc: "PILER v1.0\nhttp://www.drive5.com/piler\nWritten by Robert C. Edgar\nThis software
  is donated to the public domain.\nPlease visit web site for requested citation.\n\
  \nTool homepage: https://github.com/alvarotrigo/pagePiling.js"
inputs:
  - id: alnfile
    type: File
    doc: Input alignment file for -cons mode
    inputBinding:
      position: 1
  - id: gff
    type: File
    doc: Input GFF file for -annot mode
    inputBinding:
      position: 2
  - id: hitfile
    type: File
    doc: Input hit file for -trs mode
    inputBinding:
      position: 3
  - id: trsfile
    type: File
    doc: Input trs file for -trs2fasta mode
    inputBinding:
      position: 4
  - id: annot
    type:
      - 'null'
      - boolean
    doc: Annotate repeats
    inputBinding:
      position: 105
      prefix: -annot
  - id: cons
    type:
      - 'null'
      - boolean
    doc: Generate consensus sequence
    inputBinding:
      position: 105
      prefix: -cons
  - id: images
    type:
      - 'null'
      - File
    doc: Image file for -trs options
    inputBinding:
      position: 105
      prefix: -images
  - id: label
    type:
      - 'null'
      - string
    doc: Label for consensus sequence in -cons mode
    inputBinding:
      position: 105
      prefix: -label
  - id: maxfam
    type:
      - 'null'
      - int
    doc: Maximum family size for -trs2fasta mode
    inputBinding:
      position: 105
      prefix: -maxfam
  - id: maxlengthdiffpct
    type:
      - 'null'
      - float
    doc: Maximum length difference percentage for -trs options
    inputBinding:
      position: 105
      prefix: -maxlengthdiffpct
  - id: mincover
    type:
      - 'null'
      - int
    doc: Minimum coverage for -trs options
    inputBinding:
      position: 105
      prefix: -mincover
  - id: multihit
    type:
      - 'null'
      - boolean
    doc: Enable multi-hit for -trs options
    inputBinding:
      position: 105
      prefix: -multihit
  - id: path
    type:
      - 'null'
      - string
    doc: Path for -trs2fasta mode
    inputBinding:
      position: 105
      prefix: -path
  - id: piles
    type:
      - 'null'
      - File
    doc: Pile file for -trs options
    inputBinding:
      position: 105
      prefix: -piles
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages
    inputBinding:
      position: 105
      prefix: -quiet
  - id: repfile
    type:
      - 'null'
      - File
    doc: Repeat file for -annot mode
    inputBinding:
      position: 105
      prefix: -rep
  - id: seq
    type:
      - 'null'
      - File
    doc: Input fasta file for -trs2fasta mode
    inputBinding:
      position: 105
      prefix: -seq
  - id: trs
    type:
      - 'null'
      - boolean
    doc: Process hitfile to trsfile
    inputBinding:
      position: 105
      prefix: -trs
  - id: trs2fasta
    type:
      - 'null'
      - boolean
    doc: Convert trsfile to fastafile
    inputBinding:
      position: 105
      prefix: -trs2fasta
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piler:0.1--0
