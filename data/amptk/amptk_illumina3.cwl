cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-process_illumina_raw.py
label: amptk_illumina3
doc: "Script finds barcodes, strips forward and reverse primers, relabels, and then\n\
  trim/pads reads to a set length\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: input_fastq
    type: File
    doc: Illumina FASTQ R1 reads
    inputBinding:
      position: 1
  - id: barcode_fasta
    type:
      - 'null'
      - File
    doc: FASTA file containing Barcodes (Names & Sequences)
    inputBinding:
      position: 102
      prefix: --barcode_fasta
  - id: barcode_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in barcode
    inputBinding:
      position: 102
      prefix: --barcode_mismatch
  - id: barcode_rev_comp
    type:
      - 'null'
      - boolean
    doc: Reverse complement barcode sequences
    inputBinding:
      position: 102
      prefix: --barcode_rev_comp
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: remove intermediate files
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 102
      prefix: --cpus
  - id: forward_fastq
    type:
      - 'null'
      - File
    doc: Illumina FASTQ R1 reads
    inputBinding:
      position: 102
      prefix: --forward
  - id: fwd_primer
    type:
      - 'null'
      - string
    doc: Forward Primer
    inputBinding:
      position: 102
      prefix: --fwd_primer
  - id: index_fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina FASTQ index reads
    inputBinding:
      position: 102
      prefix: --index
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: QIIME-like mapping file
    inputBinding:
      position: 102
      prefix: --mapping_file
  - id: merge_method
    type:
      - 'null'
      - string
    doc: Software to use for PE read merging
    inputBinding:
      position: 102
      prefix: --merge_method
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    inputBinding:
      position: 102
      prefix: --min_len
  - id: no_primer_trim
    type:
      - 'null'
      - boolean
    doc: Do not trim primers
    inputBinding:
      position: 102
      prefix: --no-primer-trim
  - id: output_base
    type:
      - 'null'
      - string
    doc: Base name for output
    inputBinding:
      position: 102
      prefix: --out
  - id: pad
    type:
      - 'null'
      - string
    doc: Pad with Ns to a set length
    inputBinding:
      position: 102
      prefix: --pad
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    inputBinding:
      position: 102
      prefix: --primer_mismatch
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length, i.e. 2 x 300 bp = 300
    inputBinding:
      position: 102
      prefix: --read_length
  - id: rescue_forward
    type:
      - 'null'
      - string
    doc: Rescue Not-merged forward reads
    inputBinding:
      position: 102
      prefix: --rescue_forward
  - id: rev_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer
    inputBinding:
      position: 102
      prefix: --rev_primer
  - id: reverse_fastq
    type:
      - 'null'
      - File
    doc: Illumina FASTQ R2 reads
    inputBinding:
      position: 102
      prefix: --reverse
  - id: trim_len
    type:
      - 'null'
      - int
    doc: Trim length for reads
    inputBinding:
      position: 102
      prefix: --trim_len
  - id: usearch
    type:
      - 'null'
      - string
    doc: USEARCH9 EXE
    inputBinding:
      position: 102
      prefix: --usearch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_illumina3.out
