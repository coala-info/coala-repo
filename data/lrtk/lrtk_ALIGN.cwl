cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - ALIGN
label: lrtk_ALIGN
doc: "Align linked-read FASTQ files (10x, stLFR or TELL-Seq) to a reference genome with barcode-aware alignment, sort the alignment, mark duplicates and write alignment statistics.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
inputs:
  - id: input_fastq1
    type:
      - 'null'
      - File
    doc: Input fastq file (uncompressed FASTQ format), the first read of paired linked-read sequencing data.
    inputBinding:
      position: 1
      prefix: -FQ1
  - id: input_fastq2
    type:
      - 'null'
      - File
    doc: Input fastq file (uncompressed FASTQ format), the second read of paired linked-read sequencing data.
    inputBinding:
      position: 1
      prefix: -FQ2
  - id: read_group
    type:
      - 'null'
      - string
    doc: 'Full read group string (e.g. @RG ID:foo SM:bar)'
    inputBinding:
      position: 1
      prefix: -RG
  - id: reference
    type: File
    doc: The indexed human reference genome file.
    secondaryFiles:
      - pattern: .amb
      - pattern: .ann
      - pattern: .bwt
      - pattern: .pac
      - pattern: .sa
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: -R
  - id: outfile
    type: string
    doc: The output alignment file.
    inputBinding:
      position: 1
      prefix: -O
  - id: sort
    type:
      - 'null'
      - type: enum
        symbols:
          - 'Yes'
          - 'No'
    doc: Users can choose from (Yes, No). "Yes" means LRTK will use samtools to sort alignment files based on genomic coordinate.
    inputBinding:
      position: 1
      prefix: -S
  - id: mark_duplication
    type:
      - 'null'
      - type: enum
        symbols:
          - 'Yes'
          - 'No'
    doc: Users can choose from (Yes, No). "Yes" means LRTK will use picard to mark the duplicated reads using barcode information.
    inputBinding:
      position: 1
      prefix: -M
  - id: platform
    type:
      - 'null'
      - type: enum
        symbols:
          - 10x
          - stLFR
          - TELLSeq
    doc: Input sequencing technology. Users can choose from (10x,stLFR,TELLSeq).
    inputBinding:
      position: 1
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, this determines the number of threads used for ema, bwa and samtools.
    inputBinding:
      position: 1
      prefix: -T
  - id: genome
    type:
      - 'null'
      - type: enum
        symbols:
          - human
          - metagenome
    doc: genome pattern to process
    inputBinding:
      position: 1
      prefix: -G
outputs:
  - id: alignment
    type: File
    doc: The output alignment file (BAM) with its index.
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: $(inputs.outfile)
  - id: statistics
    type:
      - type: array
        items: File
    doc: Alignment statistics written next to the alignment file.
    outputBinding:
      glob:
        - $(inputs.outfile).AlignmentStat.xls
        - $(inputs.outfile).Insert.pdf
        - $(inputs.outfile).Cumulative.pdf
        - $(inputs.outfile).Depth.pdf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
