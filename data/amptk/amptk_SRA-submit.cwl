cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-fastq2sra.py
label: amptk_SRA-submit
doc: "Script to split FASTQ file from Ion, 454, or Illumina by barcode sequence into
  separate files for submission to SRA. This script can take the BioSample worksheet
  from NCBI and create an SRA metadata file for submission.\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: append
    type:
      - 'null'
      - string
    doc: Append a name to all sample names for a run, i.e. --append run1 would 
      yield Sample_run1
    inputBinding:
      position: 101
      prefix: --append
  - id: barcode_fasta
    type:
      - 'null'
      - File
    doc: Multi-fasta file containing barcodes used
    inputBinding:
      position: 101
      prefix: --barcode_fasta
  - id: barcode_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in barcode
    inputBinding:
      position: 101
      prefix: --barcode_mismatch
  - id: barcode_rev_comp
    type:
      - 'null'
      - boolean
    doc: Reverse complement barcode sequences
    inputBinding:
      position: 101
      prefix: --barcode_rev_comp
  - id: biosample
    type:
      - 'null'
      - File
    doc: BioSample file from NCBI
    inputBinding:
      position: 101
      prefix: --biosample
  - id: description
    type:
      - 'null'
      - string
    doc: Paragraph description for SRA metadata
    inputBinding:
      position: 101
      prefix: --description
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    inputBinding:
      position: 101
      prefix: --force
  - id: fwd_primer
    type:
      - 'null'
      - string
    doc: Forward Primer (fITS7)
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: input_fastq
    type: File
    doc: Input FASTQ file or folder
    inputBinding:
      position: 101
      prefix: --input
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: 'Mapping file: QIIME format can have extra meta data columns'
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of read to keep
    inputBinding:
      position: 101
      prefix: --min_len
  - id: names
    type:
      - 'null'
      - File
    doc: CSV mapping file BC,NewName
    inputBinding:
      position: 101
      prefix: --names
  - id: out
    type:
      - 'null'
      - string
    doc: Basename for output folder/files
    inputBinding:
      position: 101
      prefix: --out
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing platform
    inputBinding:
      position: 101
      prefix: --platform
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    inputBinding:
      position: 101
      prefix: --primer_mismatch
  - id: reads_forward
    type:
      - 'null'
      - File
    doc: Illumina FASTQ R1 reads
    inputBinding:
      position: 101
      prefix: --reads-forward
  - id: reads_index
    type:
      - 'null'
      - File
    doc: Illumina FASTQ index reads
    inputBinding:
      position: 101
      prefix: --reads-index
  - id: reads_reverse
    type:
      - 'null'
      - File
    doc: Illumina FASTQ R2 reads
    inputBinding:
      position: 101
      prefix: --reads-reverse
  - id: require_primer
    type:
      - 'null'
      - string
    doc: Require Primers to be present
    inputBinding:
      position: 101
      prefix: --require_primer
  - id: rev_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer (ITS4)
    inputBinding:
      position: 101
      prefix: --rev_primer
  - id: reverse_barcode
    type:
      - 'null'
      - File
    doc: Reverse barcode fasta file
    inputBinding:
      position: 101
      prefix: --reverse_barcode
  - id: title
    type:
      - 'null'
      - string
    doc: Start of title for SRA submission, name it according to amplicon
    inputBinding:
      position: 101
      prefix: --title
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_SRA-submit.out
