cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_pair
label: fastq-pair
doc: "A tool to rewrite paired-end FASTQ files so that the reads match up and are
  in the same order in both files.\n\nTool homepage: https://github.com/linsalrob/fastq-pair"
inputs:
  - id: fastq_1
    type: File
    doc: First FASTQ file (usually R1)
    inputBinding:
      position: 1
  - id: fastq_2
    type: File
    doc: Second FASTQ file (usually R2)
    inputBinding:
      position: 2
  - id: table_size
    type:
      - 'null'
      - int
    doc: table size (default 100003)
    inputBinding:
      position: 0
      prefix: -t
  - id: print_bucket_sizes
    type:
      - 'null'
      - boolean
    doc: print the number of elements in each bucket in the table
    inputBinding:
      position: 0
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output. This is mainly for debugging
    inputBinding:
      position: 0
      prefix: -v
outputs:
  - id: paired_1
    type:
      - 'null'
      - File
    doc: Paired reads from the first file (<file1>.paired.fq)
    outputBinding:
      glob: $(inputs.fastq_1.basename).paired.fq
  - id: paired_2
    type:
      - 'null'
      - File
    doc: Paired reads from the second file (<file2>.paired.fq)
    outputBinding:
      glob: $(inputs.fastq_2.basename).paired.fq
  - id: single_1
    type:
      - 'null'
      - File
    doc: Reads of the first file without a mate (<file1>.single.fq)
    outputBinding:
      glob: $(inputs.fastq_1.basename).single.fq
  - id: single_2
    type:
      - 'null'
      - File
    doc: Reads of the second file without a mate (<file2>.single.fq)
    outputBinding:
      glob: $(inputs.fastq_2.basename).single.fq
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fastq_1)
      - $(inputs.fastq_2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-pair:1.0--h87f3376_3
stdout: fastq-pair.out
