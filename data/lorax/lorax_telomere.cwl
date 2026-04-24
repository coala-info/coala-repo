cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - telomere
label: lorax_telomere
doc: "Identify telomeric repeats in BAM or FASTA files.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: reads_fasta
    type: File
    doc: reads FASTA file
    inputBinding:
      position: 1
  - id: ref_fa
    type: File
    doc: genome fasta file
    inputBinding:
      position: 2
  - id: tumor_bam
    type: File
    doc: tumor BAM file
    inputBinding:
      position: 3
  - id: chrlen
    type:
      - 'null'
      - int
    doc: min. chromosome length
    inputBinding:
      position: 104
      prefix: --chrlen
  - id: genome
    type:
      - 'null'
      - File
    doc: genome fasta file
    inputBinding:
      position: 104
      prefix: --genome
  - id: medsize
    type:
      - 'null'
      - int
    doc: rolling median window
    inputBinding:
      position: 104
      prefix: --medsize
  - id: minclip
    type:
      - 'null'
      - int
    doc: min. clipping length
    inputBinding:
      position: 104
      prefix: --minclip
  - id: movavg
    type:
      - 'null'
      - int
    doc: rolling average window
    inputBinding:
      position: 104
      prefix: --movavg
  - id: outprefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 104
      prefix: --outprefix
  - id: repeats
    type:
      - 'null'
      - string
    doc: repeat units
    inputBinding:
      position: 104
      prefix: --repeats
  - id: thres
    type:
      - 'null'
      - float
    doc: repeat threshold
    inputBinding:
      position: 104
      prefix: --thres
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
stdout: lorax_telomere.out
