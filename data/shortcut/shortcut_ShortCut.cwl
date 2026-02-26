cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShortCut
label: shortcut_ShortCut
doc: "ShortCut\n\nTool homepage: https://github.com/Aez35/ShortCut"
inputs:
  - id: fastq
    type:
      type: array
      items: File
    doc: One or more fastq alignment files
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Specify whether you want ShortStack to annotate
    inputBinding:
      position: 102
      prefix: -annotate
  - id: dn_mirna
    type:
      - 'null'
      - string
    doc: De novo miRNA search in ShortStack
    inputBinding:
      position: 102
      prefix: -dn_mirna
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome for annotation
    inputBinding:
      position: 102
      prefix: -genome
  - id: kingdom
    type: string
    doc: Specify animal or plant
    inputBinding:
      position: 102
      prefix: -kingdom
  - id: known_mirnas
    type:
      - 'null'
      - File
    doc: FASTA-formatted file of known mature miRNA sequences
    inputBinding:
      position: 102
      prefix: -known_mirnas
  - id: m
    type:
      - 'null'
      - int
    doc: Minimum length of reads for Cutadapt
    inputBinding:
      position: 102
      prefix: -m
  - id: n
    type:
      - 'null'
      - string
    doc: Results file name
    inputBinding:
      position: 102
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify number of threads for samtools
    inputBinding:
      position: 102
      prefix: -threads
  - id: trimkey
    type:
      - 'null'
      - string
    doc: Abundant miRNA used to find adapters for trimming with option -autotrim
    inputBinding:
      position: 102
      prefix: -trimkey
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out)
  - id: ssout
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.ssout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortcut:1.0--hdfd78af_0
