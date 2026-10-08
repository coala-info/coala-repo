cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - FQCONVER
label: lrtk_fqconver
doc: "Convert raw 10x, stLFR or TELL-Seq linked-read FASTQ files to the unified linked-read format (barcode in a BX:Z tag).\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_fastq1
    type: File
    doc: Input fastq file (uncompressed FASTQ format), the first read of paired linked-read sequencing data
    inputBinding:
      position: 1
      prefix: -I1
  - id: input_fastq2
    type: File
    doc: Input fastq file (uncompressed FASTQ format), the second read of paired linked-read sequencing data
    inputBinding:
      position: 1
      prefix: -I2
  - id: index_fastq
    type:
      - 'null'
      - File
    doc: Input index file (uncompressed FASTQ format) for paired linked-read sequencing data; required for TELLSeq.
    inputBinding:
      position: 1
      prefix: -ID
  - id: input_type
    type:
      - 'null'
      - string
    doc: Input sequencing technology. Users can choose from (10x,stLFR,TELLSeq).
    inputBinding:
      position: 1
      prefix: -IT
  - id: output_fastq1
    type: string
    doc: Output fastq file, the first read of paired linked-read sequencing data
    inputBinding:
      position: 1
      prefix: -O1
  - id: output_fastq2
    type: string
    doc: Output fastq file, the second read of paired linked-read sequencing data.
    inputBinding:
      position: 1
      prefix: -O2
  - id: barcodes
    type:
      - 'null'
      - File
    doc: The reference barcode whitelist file for 10x and stLFR technologies (FASTA, indexed with bwa index).
    secondaryFiles:
      - pattern: .amb
        required: true
      - pattern: .ann
        required: true
      - pattern: .bwt
        required: true
      - pattern: .pac
        required: true
      - pattern: .sa
        required: true
    inputBinding:
      position: 1
      prefix: -BW
  - id: host
    type:
      - 'null'
      - File
    doc: The host reference genome database, required for metagenomic sequencing
    inputBinding:
      position: 1
      prefix: -HD
  - id: filter
    type:
      - 'null'
      - string
    doc: Yes or No. Yes indicates that LRTK will use fastp to filter reads.
    inputBinding:
      position: 1
      prefix: -F
  - id: sort
    type:
      - 'null'
      - string
    doc: Yes or No. Yes indicates that LRTK will sort the reads based on barcodes.
    inputBinding:
      position: 1
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, this determines the number of threads used for bwa and samtools
    inputBinding:
      position: 1
      prefix: -T
  - id: genome
    type:
      - 'null'
      - string
    doc: Indicator of the input organism (human or metagenome).
    inputBinding:
      position: 1
      prefix: -G
outputs:
  - id: out_fastq1
    type: File
    doc: Converted first-read FASTQ with BX:Z barcode tags.
    outputBinding:
      glob: $(inputs.output_fastq1)
  - id: out_fastq2
    type: File
    doc: Converted second-read FASTQ with BX:Z barcode tags.
    outputBinding:
      glob: $(inputs.output_fastq2)
  - id: qc_reports
    type:
      type: array
      items: File
    doc: fastp QC reports (FASTQ.QC.html, FASTQ.QC.json) when filtering is on.
    outputBinding:
      glob: FASTQ.QC.*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
