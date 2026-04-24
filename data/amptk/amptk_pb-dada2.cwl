cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-dada2.py
label: amptk_pb-dada2
doc: "Script takes output from amptk pre-processing and runs pacbio DADA2\n\nTool
  homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: barcode_qual
    type:
      - 'null'
      - int
    doc: Barcode Quality threshold
    inputBinding:
      position: 101
      prefix: --barcode_qual
  - id: chimera_method
    type:
      - 'null'
      - string
    doc: bimera removal method
    inputBinding:
      position: 101
      prefix: --chimera_method
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq
    type: File
    doc: Input Demuxed containing FASTQ
    inputBinding:
      position: 101
      prefix: --fastq
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads after Q filtering to run DADA2 on
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: pct_otu
    type:
      - 'null'
      - float
    doc: Biological OTU Clustering Percent
    inputBinding:
      position: 101
      prefix: --pct_otu
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing platform
    inputBinding:
      position: 101
      prefix: --platform
  - id: pool
    type:
      - 'null'
      - boolean
    doc: Pool all sequences together for DADA2
    inputBinding:
      position: 101
      prefix: --pool
  - id: pseudopool
    type:
      - 'null'
      - boolean
    doc: Use DADA2 pseudopooling
    inputBinding:
      position: 101
      prefix: --pseudopool
  - id: read_qual
    type:
      - 'null'
      - float
    doc: Read Quality threshold
    inputBinding:
      position: 101
      prefix: --read_qual
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
