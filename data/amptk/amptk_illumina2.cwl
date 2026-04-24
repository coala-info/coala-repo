cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-process_ion.py
label: amptk_illumina2
doc: "Script finds barcodes, strips forward and reverse primers, relabels, and then
  trim/pads reads to a set length\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: barcode_fasta
    type:
      - 'null'
      - File
    doc: FASTA file containing Barcodes (Names & Sequences)
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
  - id: barcode_not_anchored
    type:
      - 'null'
      - boolean
    doc: Barcodes (indexes) are not at start of reads
    inputBinding:
      position: 101
      prefix: --barcode_not_anchored
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: f_primer
    type:
      - 'null'
      - string
    doc: Forward Primer
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: fastq
    type: File
    doc: FASTQ R1 file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Keep only full length reads (no trimming/padding)
    inputBinding:
      position: 101
      prefix: --full_length
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: 'Mapping file: QIIME format can have extra meta data columns'
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: merge_method
    type:
      - 'null'
      - string
    doc: Software to use for PE read merging
    inputBinding:
      position: 101
      prefix: --merge_method
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    inputBinding:
      position: 101
      prefix: --min_len
  - id: out
    type:
      - 'null'
      - string
    doc: Base name for output
    inputBinding:
      position: 101
      prefix: --out
  - id: pad
    type:
      - 'null'
      - string
    doc: Pad with Ns to a set length
    inputBinding:
      position: 101
      prefix: --pad
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    inputBinding:
      position: 101
      prefix: --primer_mismatch
  - id: r_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer
    inputBinding:
      position: 101
      prefix: --rev_primer
  - id: reverse
    type:
      - 'null'
      - File
    doc: Illumina R2 reverse reads
    inputBinding:
      position: 101
      prefix: --reverse
  - id: reverse_barcode
    type:
      - 'null'
      - File
    doc: FASTA file containing 3 prime Barocdes
    inputBinding:
      position: 101
      prefix: --reverse_barcode
  - id: trim_len
    type:
      - 'null'
      - int
    doc: Trim length for reads
    inputBinding:
      position: 101
      prefix: --trim_len
  - id: usearch
    type:
      - 'null'
      - string
    doc: USEARCH EXE
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
stdout: amptk_illumina2.out
