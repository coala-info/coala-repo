cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-process_ion.py
label: amptk_454
doc: "Script finds barcodes, strips forward and reverse primers, relabels, and then
  trim/pads reads to a set length\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: barcode_fasta
    type:
      - 'null'
      - File
    doc: FASTA file containing Barcodes (Names & Sequences)
    default: ionxpress
    inputBinding:
      position: 101
      prefix: --barcode_fasta
  - id: barcode_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in barcode
    default: 0
    inputBinding:
      position: 101
      prefix: --barcode_mismatch
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    default: auto
    inputBinding:
      position: 101
      prefix: --cpus
  - id: forward_primer
    type:
      - 'null'
      - string
    doc: Forward Primer
    default: fITS7-ion
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Keep only full length reads (no trimming/padding)
    default: false
    inputBinding:
      position: 101
      prefix: --full_length
  - id: input_454
    type:
      - 'null'
      - boolean
    doc: Input data is 454
    default: false
    inputBinding:
      position: 101
      prefix: --454
  - id: input_file
    type: File
    doc: BAM/FASTQ/SFF/FASTA file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: ion
    type:
      - 'null'
      - boolean
    doc: Input data is Ion Torrent
    default: false
    inputBinding:
      position: 101
      prefix: --ion
  - id: list_barcodes
    type:
      - 'null'
      - string
    doc: Enter Barcodes used separated by commas
    default: all
    inputBinding:
      position: 101
      prefix: --list_barcodes
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
    doc: Minimum read length to keep
    default: 100
    inputBinding:
      position: 101
      prefix: --min_len
  - id: mult_samples
    type:
      - 'null'
      - string
    doc: Combine multiple samples (i.e. FACE1)
    default: 'False'
    inputBinding:
      position: 101
      prefix: --mult_samples
  - id: output_base_name
    type:
      - 'null'
      - string
    doc: Base name for output
    default: ion
    inputBinding:
      position: 101
      prefix: --out
  - id: pad
    type:
      - 'null'
      - string
    doc: Pad with Ns to a set length
    default: off
    inputBinding:
      position: 101
      prefix: --pad
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    default: 2
    inputBinding:
      position: 101
      prefix: --primer_mismatch
  - id: qual_file
    type:
      - 'null'
      - File
    doc: QUAL file (if -i is FASTA)
    inputBinding:
      position: 101
      prefix: --qual
  - id: reverse_barcode
    type:
      - 'null'
      - File
    doc: FASTA file containing 3 prime Barocdes
    inputBinding:
      position: 101
      prefix: --reverse_barcode
  - id: reverse_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer
    default: ITS4
    inputBinding:
      position: 101
      prefix: --rev_primer
  - id: trim_len
    type:
      - 'null'
      - int
    doc: Trim length for reads
    default: 300
    inputBinding:
      position: 101
      prefix: --trim_len
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_454.out
