cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2fasta
label: bam2fasta
doc: "A tool to convert BAM files to FASTA or FASTQ files, specifically designed for
  single-cell data to group sequences by barcodes.\n\nTool homepage: https://github.com/czbiohub/bam2fasta"
inputs:
  - id: filename
    type:
      - 'null'
      - string
    doc: Output filename prefix
    inputBinding:
      position: 101
      prefix: --filename
  - id: input_bam
    type: File
    doc: Path to the input BAM file
    inputBinding:
      position: 101
      prefix: --input_bam
  - id: min_barcode_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads per barcode to include in the output
    inputBinding:
      position: 101
      prefix: --min-barcode-reads
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use for parallelization
    inputBinding:
      position: 101
      prefix: --processes
  - id: save_fastqs
    type:
      - 'null'
      - boolean
    doc: If set, save the output as FASTQ files instead of FASTA
    inputBinding:
      position: 101
      prefix: --save-fastqs
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2fasta:1.0.8--pyh3252c3a_0
