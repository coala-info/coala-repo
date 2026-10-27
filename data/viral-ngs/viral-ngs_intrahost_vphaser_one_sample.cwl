cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - intrahost.py
  - vphaser_one_sample
label: viral-ngs_intrahost_vphaser_one_sample
doc: "Input: a single BAM file, representing reads from one sample, mapped to its own consensus assembly. It may contain multiple read groups and libraries. Output: a tab-separated file with no header containing filtered V Phaser-2 output variants with additional column for sequence/chrom name, and library counts and p-values appended to the counts for each allele.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input Bam file."
    inputBinding:
      position: 1
  - id: in_cons_fasta
    type: File
    doc: "Consensus assembly fasta."
    inputBinding:
      position: 2
  - id: out_tab
    type: string
    doc: "Tab-separated headerless output file."
    inputBinding:
      position: 3
  - id: vphaser_num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads in call to V-Phaser 2."
    inputBinding:
      position: 20
      prefix: --vphaserNumThreads
  - id: min_reads_each
    type:
      - 'null'
      - int
    doc: "Minimum number of reads on each strand (default: 5)."
    inputBinding:
      position: 20
      prefix: --minReadsEach
  - id: max_bias
    type:
      - 'null'
      - int
    doc: "Maximum allowable ratio of number of reads on the two strands (default: 10). Ignored if minReadsEach = 0."
    inputBinding:
      position: 20
      prefix: --maxBias
  - id: remove_doubly_mapped_reads
    type:
      - 'null'
      - boolean
    doc: "When calling V-Phaser, remove reads mapping to more than one contig. Default is to keep the reads."
    inputBinding:
      position: 20
      prefix: --removeDoublyMappedReads
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_tab_file
    type: File
    doc: "V-Phaser variants table"
    outputBinding:
      glob: $(inputs.out_tab)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_intrahost_vphaser_one_sample.out
