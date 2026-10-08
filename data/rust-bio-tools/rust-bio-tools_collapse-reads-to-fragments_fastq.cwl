cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - collapse-reads-to-fragments
  - fastq
label: rust-bio-tools_collapse-reads-to-fragments_fastq
doc: "Tool to merge sets of reads from paired FASTQ files that share the UMI and have
  similar read sequence. The result is a maximum likelihood fragment sequence per
  set with base quality scores improved accordingly. Duplicates are identified by
  a Unique Molecular Identifier (UMI).\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: fq1
    type: File
    doc: Input FASTQ file with forward reads.
    inputBinding:
      position: 1
  - id: fq2
    type: File
    doc: Input FASTQ file with reverse reads.
    inputBinding:
      position: 2
  - id: consensus_fq1
    type: string
    doc: Output FASTQ file with forward reads
    inputBinding:
      position: 3
  - id: consensus_fq2
    type: string
    doc: Output FASTQ file with reverse reads
    inputBinding:
      position: 4
  - id: consensus_fq3
    type:
      - 'null'
      - string
    doc: Output FASTQ file for overlapping consensus reads (Required for calculating
      overlapping consensus only)
    inputBinding:
      position: 5
  - id: insert_size
    type:
      - 'null'
      - int
    doc: Expected insert size of sequenced fragment (Required for calculating overlapping
      consensus only)
    inputBinding:
      position: 101
      prefix: --insert-size
  - id: max_seq_dist
    type:
      - 'null'
      - int
    doc: 'Maximum hamming distance between the sequences of any pair of reads in the
      same cluster. [default: 2] [possible values: 1-8]'
    inputBinding:
      position: 101
      prefix: --max-seq-dist
  - id: max_umi_dist
    type:
      - 'null'
      - int
    doc: 'Maximum hamming distance between the UMIs of any pair of reads in the same
      cluster. [default: 1]'
    inputBinding:
      position: 101
      prefix: --max-umi-dist
  - id: std_dev
    type:
      - 'null'
      - int
    doc: Standard deviation of expected insert size. Defines search space of the most
      likely overlap. (Required for calculating overlapping consensus only)
    inputBinding:
      position: 101
      prefix: --std-dev
  - id: umi_len
    type:
      - 'null'
      - int
    doc: 'Length of UMI in read. [default: 8]'
    inputBinding:
      position: 101
      prefix: --umi-len
  - id: umi_on_reverse
    type:
      - 'null'
      - boolean
    doc: Set if UMI is on reverse read
    inputBinding:
      position: 101
      prefix: --umi-on-reverse
  - id: verbose_read_names
    type:
      - 'null'
      - boolean
    doc: Add list of reads that were merged for each consensus read. Note that this
      can yield very long FASTQ name lines which cannot be handled by some tools.
    inputBinding:
      position: 101
      prefix: --verbose-read-names
outputs:
  - id: consensus_fq1_file
    type: File
    doc: FASTQ file with forward consensus reads
    outputBinding:
      glob: $(inputs.consensus_fq1)
  - id: consensus_fq2_file
    type: File
    doc: FASTQ file with reverse consensus reads
    outputBinding:
      glob: $(inputs.consensus_fq2)
  - id: consensus_fq3_file
    type:
      - 'null'
      - File
    doc: FASTQ file with overlapping consensus reads
    outputBinding:
      glob: $(inputs.consensus_fq3)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
