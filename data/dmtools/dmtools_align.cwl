cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools align
label: dmtools_align
doc: "Align reads to a genome.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: align_taps
    type:
      - 'null'
      - boolean
    doc: alignment TAPS reads with bwa mem
    inputBinding:
      position: 101
      prefix: --taps
  - id: fastp_location
    type:
      - 'null'
      - string
    doc: fastp program location for fastq preprocess. if --fastp is not defined,
      the input file should be clean data.
    inputBinding:
      position: 101
      prefix: --fastp
  - id: genome
    type: File
    doc: genome fasta file
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file, support .fq/.fastq and .gz/.gzip format. if paired-end. 
      please use -1, -2
    inputBinding:
      position: 101
      prefix: -i
  - id: input_left
    type:
      - 'null'
      - File
    doc: input file left end, if single-end. please use -i
    inputBinding:
      position: 101
      prefix: '-1'
  - id: input_right
    type:
      - 'null'
      - File
    doc: input file right end
    inputBinding:
      position: 101
      prefix: '-2'
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of bam output file
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
