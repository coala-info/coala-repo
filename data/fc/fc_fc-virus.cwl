cwlVersion: v1.2
class: CommandLineTool
baseCommand: fc_fc-virus
label: fc_fc-virus
doc: "FC-Virus Usage\n\nTool homepage: https://github.com/qdu-bioinfo/fc-virus"
inputs:
  - id: file_type
    type:
      - 'null'
      - string
    doc: type of file, fa or fq
    inputBinding:
      position: 101
      prefix: -t
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of kmer
    default: 21
    inputBinding:
      position: 101
      prefix: -k
  - id: left_reads_file
    type:
      - 'null'
      - File
    doc: left reads file name (.fasta or .fastq)
    inputBinding:
      position: 101
      prefix: --left
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: paired-end reads
    inputBinding:
      position: 101
      prefix: -p
  - id: right_reads_file
    type:
      - 'null'
      - File
    doc: right reads file name (.fasta or .fastq)
    inputBinding:
      position: 101
      prefix: --right
  - id: single_end_file
    type:
      - 'null'
      - File
    doc: reads file name (.fasta or .fastq)
    inputBinding:
      position: 101
      prefix: -singlefile
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
    dockerPull: quay.io/biocontainers/fc:1.0.1--h5ca1c30_1
