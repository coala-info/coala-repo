cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./hera quant
label: hera_quant
doc: "Hera is a program developed by BioTuring for RNA-Seq analysis.\n\nTool homepage:
  https://github.com/bioturing/hera"
inputs:
  - id: index_directory
    type: Directory
    doc: Path to index directory
    inputBinding:
      position: 1
  - id: r1_fq
    type: File
    doc: R1 fastq file
    inputBinding:
      position: 2
  - id: r2_fq
    type: File
    doc: R2 fastq file
    inputBinding:
      position: 3
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compress level (1 - 9)
    inputBinding:
      position: 104
      prefix: -z
  - id: genome_fasta_file
    type:
      - 'null'
      - File
    doc: Genome fasta file (if not define, genome mapping will be ignore)
    inputBinding:
      position: 104
      prefix: -f
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstraps
    inputBinding:
      position: 104
      prefix: -b
  - id: output_bam_file
    type:
      - 'null'
      - boolean
    doc: 'Output bam file 0:true, 1: false'
    inputBinding:
      position: 104
      prefix: -w
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 104
      prefix: -o
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 104
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hera:1.1--h8121788_3
stdout: hera_quant.out
