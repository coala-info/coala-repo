cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - collapse-reads-to-fragments
  - bam
label: rust-bio-tools_collapse-reads-to-fragments_bam
doc: "Tool to merge sets of PCR duplicate reads from a BAM file into one maximum likelihood
  fragment sequence each with accordingly improved base quality scores. Takes a BAM
  file and returns FASTQ files in which all PCR duplicates have been merged into a
  consensus read. Duplicates must be marked by Picard Tools using the TAG_DUPLICATE_SET_MEMBERS
  option.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: bam
    type: File
    doc: Input BAM file with marked duplicates
    inputBinding:
      position: 1
  - id: consensus_fq1
    type: string
    doc: Output FASTQ file with forward reads
    inputBinding:
      position: 2
  - id: consensus_fq2
    type: string
    doc: Output FASTQ file with reverse reads
    inputBinding:
      position: 3
  - id: consensus_fq_se
    type: string
    doc: Output FASTQ file for overlapping consensus reads.
    inputBinding:
      position: 4
  - id: skipped_bam
    type: string
    doc: Output BAM file for reads that were skipped (not merged).
    inputBinding:
      position: 5
  - id: annotate_record_ids
    type:
      - 'null'
      - boolean
    doc: Add list of reads that were merged for each consensus read. Note that this
      can yield very long FASTQ name lines which cannot be handled by some tools.
    inputBinding:
      position: 101
      prefix: --annotate-record-ids
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
  - id: consensus_fq_se_file
    type: File
    doc: FASTQ file with overlapping consensus reads
    outputBinding:
      glob: $(inputs.consensus_fq_se)
  - id: skipped_bam_file
    type: File
    doc: BAM file with skipped reads
    outputBinding:
      glob: $(inputs.skipped_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
