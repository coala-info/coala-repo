cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-dada2.py
label: amptk_dada2
doc: "Script takes output from amptk pre-processing and runs DADA2\n\nTool homepage:
  https://github.com/nextgenusfs/amptk"
inputs:
  - id: chimera_method
    type:
      - 'null'
      - string
    doc: bimera removal method
    default: consensus
    inputBinding:
      position: 101
      prefix: --chimera_method
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq
    type: File
    doc: Input Demuxed containing FASTQ
    inputBinding:
      position: 101
      prefix: --fastq
  - id: length
    type:
      - 'null'
      - int
    doc: Length to truncate reads
    inputBinding:
      position: 101
      prefix: --length
  - id: maxee
    type:
      - 'null'
      - float
    doc: MaxEE quality filtering
    default: 1.0
    inputBinding:
      position: 101
      prefix: --maxee
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads after Q filtering to run DADA2 on
    default: 10
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: pct_otu
    type:
      - 'null'
      - float
    doc: Biological OTU Clustering Percent
    default: 97
    inputBinding:
      position: 101
      prefix: --pct_otu
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing platform
    default: ion
    inputBinding:
      position: 101
      prefix: --platform
  - id: pool
    type:
      - 'null'
      - boolean
    doc: Pool all sequences together for DADA2
    default: false
    inputBinding:
      position: 101
      prefix: --pool
  - id: pseudopool
    type:
      - 'null'
      - boolean
    doc: Use DADA2 pseudopooling
    default: false
    inputBinding:
      position: 101
      prefix: --pseudopool
  - id: uchime_ref
    type:
      - 'null'
      - string
    doc: Run UCHIME REF [ITS,16S,LSU,COI,custom]
    inputBinding:
      position: 101
      prefix: --uchime_ref
  - id: usearch
    type:
      - 'null'
      - string
    doc: USEARCH9 EXE
    default: usearch9
    inputBinding:
      position: 101
      prefix: --usearch
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output Basename
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
