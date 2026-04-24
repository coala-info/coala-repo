cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_rcorrector.pl
label: rcorrector_run_rcorrector.pl
doc: "A k-mer based error correction tool for Illumina RNA-seq reads\n\nTool homepage:
  https://github.com/mourisl/Rcorrector/"
inputs:
  - id: interleaved_read
    type:
      - 'null'
      - File
    doc: interleaved fastq file
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (<=32)
    inputBinding:
      position: 101
      prefix: -k
  - id: max_memory
    type:
      - 'null'
      - string
    doc: max memory to use (in GB)
    inputBinding:
      position: 101
      prefix: -m
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 101
      prefix: -p
  - id: read1
    type:
      - 'null'
      - File
    doc: fastq file for read 1 (if paired-end)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type:
      - 'null'
      - File
    doc: fastq file for read 2 (if paired-end)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: single_end_read
    type:
      - 'null'
      - File
    doc: fastq file for single-end read
    inputBinding:
      position: 101
      prefix: -s
  - id: stdout_cor
    type:
      - 'null'
      - boolean
    doc: output corrected reads to stdout
    inputBinding:
      position: 101
      prefix: --stdout
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rcorrector:1.0.7--pl5321h5ca1c30_2
