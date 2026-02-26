cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-unoise3.py
label: amptk_unoise3
doc: "Script runs UNOISE3 algorithm. Requires USEARCH9 by Robert C. Edgar: http://drive5.com/usearch\n\
  \nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    default: None
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Remove Intermediate Files
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq
    type: File
    doc: FASTQ file (Required)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: map_filtered
    type:
      - 'null'
      - boolean
    doc: map quality filtered reads back to OTUs
    default: false
    inputBinding:
      position: 101
      prefix: --map_filtered
  - id: maxee
    type:
      - 'null'
      - float
    doc: Quality trim EE value
    default: 1.0
    inputBinding:
      position: 101
      prefix: --maxee
  - id: method
    type:
      - 'null'
      - string
    doc: Program to use
    default: vsearch
    inputBinding:
      position: 101
      prefix: --method
  - id: minsize
    type:
      - 'null'
      - int
    doc: Min size to keep for denoising
    default: 8
    inputBinding:
      position: 101
      prefix: --minsize
  - id: out
    type:
      - 'null'
      - string
    doc: Base output name
    inputBinding:
      position: 101
      prefix: --out
  - id: pct_otu
    type:
      - 'null'
      - float
    doc: Biological OTU Clustering Percent
    default: 97
    inputBinding:
      position: 101
      prefix: --pct_otu
  - id: uchime_ref
    type:
      - 'null'
      - string
    doc: Run UCHIME2 REF [ITS,16S,LSU,COI,custom]
    default: None
    inputBinding:
      position: 101
      prefix: --uchime_ref
  - id: usearch
    type:
      - 'null'
      - string
    doc: USEARCH10 EXE
    default: usearch10
    inputBinding:
      position: 101
      prefix: --usearch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_unoise3.out
