cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam2fasta
  - percell
label: bam2fasta
doc: "Convert a 10x single-cell BAM file (or fastq.gz) to one FASTA file per cell
  barcode.\n\nTool homepage: https://github.com/czbiohub/bam2fasta"
inputs:
  - id: filename
    type: File
    doc: 10x bam file or fastq.gz file
    inputBinding:
      position: 101
      prefix: --filename
  - id: min_umi_per_barcode
    type:
      - 'null'
      - int
    doc: A barcode is only considered valid and its fasta written if its number
      of UMIs is greater than this value (default 0)
    inputBinding:
      position: 101
      prefix: --min-umi-per-barcode
  - id: write_barcode_meta_csv
    type:
      - 'null'
      - string
    doc: Write the barcode and number of UMIs per barcode to this CSV path
    inputBinding:
      position: 101
      prefix: --write-barcode-meta-csv
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use for reading 10x bam file (default 2)
    inputBinding:
      position: 101
      prefix: --processes
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter between sequences of the same barcode (default X)
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: save_fastas
    type: string
    default: fastas
    doc: Directory to save the merged per-barcode fastas
    inputBinding:
      position: 101
      prefix: --save-fastas
  - id: save_intermediate_files
    type:
      - 'null'
      - string
    doc: Directory for temporary fastas and bam chunks (default /tmp/)
    inputBinding:
      position: 101
      prefix: --save-intermediate-files
  - id: shard_size
    type:
      - 'null'
      - int
    doc: Line/alignment count for each bam shard (default 1500)
    inputBinding:
      position: 101
      prefix: --shard-size
  - id: cell_barcode_pattern
    type:
      - 'null'
      - string
    doc: Regular expression for cell barcodes
    inputBinding:
      position: 101
      prefix: --cell-barcode-pattern
  - id: molecular_barcode_pattern
    type:
      - 'null'
      - string
    doc: Regular expression for molecular barcodes
    inputBinding:
      position: 101
      prefix: --molecular-barcode-pattern
  - id: rename_10x_barcodes
    type:
      - 'null'
      - File
    doc: Tab-separated file mapping 10x barcode name to new name
    inputBinding:
      position: 101
      prefix: --rename-10x-barcodes
  - id: barcodes_file
    type:
      - 'null'
      - File
    doc: Barcodes file if the input is an unfiltered 10x bam file
    inputBinding:
      position: 101
      prefix: --barcodes-file
  - id: barcodes_significant_umis_file
    type:
      - 'null'
      - File
    doc: Barcodes file with significant UMI count
    inputBinding:
      position: 101
      prefix: --barcodes-significant-umis-file
  - id: channel_id
    type:
      - 'null'
      - string
    doc: Output prefix for fastqs (fastq.gz input)
    inputBinding:
      position: 101
      prefix: --channel-id
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format for fastqs (fastq.gz input), fastq or fastq.gz
    inputBinding:
      position: 101
      prefix: --output-format
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the per-barcode fastas
    outputBinding:
      glob: $(inputs.save_fastas)
  - id: barcode_meta_csv
    type:
      - 'null'
      - File
    doc: Barcodes and number of UMIs per barcode
    outputBinding:
      glob: $(inputs.write_barcode_meta_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2fasta:1.0.8--pyh3252c3a_0
