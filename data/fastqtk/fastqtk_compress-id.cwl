cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - compress-id
label: fastqtk_compress-id
doc: "It does lossy compression on the reads ids from a FASTQ file.\n\nTool homepage:
  https://github.com/ndaniel/fastqtk"
inputs:
  - id: id_settings
    type: string
    doc: settings for generating reads ids
    inputBinding:
      position: 1
  - id: read_count_info
    type:
      - 'null'
      - string
    doc: count reads; if here is a dot then it is considered that a file has 
      been given
    inputBinding:
      position: 2
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 3
  - id: counts_file
    type:
      - 'null'
      - File
    doc: file that contains number of reads in the input FASTQ file <in.fq>, 
      that was generated using 'fastqtk count in.fq counts.txt' beforehand.
    inputBinding:
      position: 104
  - id: num_reads
    type:
      - 'null'
      - int
    doc: number of reads in the input FASTQ file (or a much larger number)
    default: 500000
    inputBinding:
      position: 104
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
