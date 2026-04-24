cwlVersion: v1.2
class: CommandLineTool
baseCommand: grid_single
label: grid_single
doc: "Processes single-end sequencing data or SAM alignment files.\n\nTool homepage:
  https://github.com/ohlab/GRiD"
inputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reads_subset_file
    type:
      - 'null'
      - File
    doc: Path to file listing a subset of reads for analysis
    inputBinding:
      position: 101
      prefix: -l
  - id: reference_genome
    type: File
    doc: Reference genome (fasta)
    inputBinding:
      position: 101
      prefix: -g
  - id: sample_extension
    type:
      - 'null'
      - string
    doc: Sample filename extension (fq, fastq, fastq.gz, sam)
    inputBinding:
      position: 101
      prefix: -e
  - id: samples_directory
    type: Directory
    doc: Samples directory (single end reads or SAM alignment files)
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grid:1.3--0
stdout: grid_single.out
