cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapsplice
label: soapsplice
doc: "SOAPsplice is a tool for genome-wide ab initio detection of splice junctions
  from RNA-Seq data, supporting both fastq and fasta formats.\n\nTool homepage:
  http://soap.genomics.org.cn/soapsplice.html"
inputs:
  - id: index_prefix
    type: string
    doc: Prefix of reference index files (for example genome.fasta.index
      for the index files written by 2bwt-builder with prefix genome.fasta)
    inputBinding:
      position: 101
      prefix: -d
  - id: index_files
    type:
      type: array
      items: File
    doc: Reference index files written by 2bwt-builder (staged so the prefix
      resolves)
  - id: query_1
    type: File
    doc: Reads file 1, FASTA/FASTQ format
    inputBinding:
      position: 101
      prefix: '-1'
  - id: query_2
    type:
      - 'null'
      - File
    doc: Reads file 2, FASTA/FASTQ format
    inputBinding:
      position: 101
      prefix: '-2'
  - id: output_prefix
    type: string
    doc: Prefix of output files, (can be with file directory)
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads, <= 20, 1 (default)'
    inputBinding:
      position: 101
      prefix: -p
  - id: strand
    type:
      - 'null'
      - int
    doc: '1: Forward, 2: Reverse, 3: Both (default)'
    inputBinding:
      position: 101
      prefix: -S
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: 'Maximum mismatch for one-segment alignment, <= 5, 3 (default)'
    inputBinding:
      position: 101
      prefix: -m
  - id: max_indel
    type:
      - 'null'
      - int
    doc: 'Maximum indel for one-segment alignment, <= 2, 2 (default)'
    inputBinding:
      position: 101
      prefix: -g
  - id: ignored_tail_length
    type:
      - 'null'
      - int
    doc: 'Length of tail that can be ignored in one-segment alignment, 7 (default)'
    inputBinding:
      position: 101
      prefix: -i
  - id: longest_gap
    type:
      - 'null'
      - int
    doc: 'Longest gap between two segments in two-segment alignment, 500000 (default)'
    inputBinding:
      position: 101
      prefix: -t
  - id: shortest_segment
    type:
      - 'null'
      - int
    doc: 'Shortest length of a segment in two-segment alignment, 8 (default)'
    inputBinding:
      position: 101
      prefix: -a
  - id: output_read_and_quality
    type:
      - 'null'
      - int
    doc: '1: Output read and its quality in one-segment alignment output file (default), 0: Do not output such information to save disk space'
    inputBinding:
      position: 101
      prefix: -c
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Format of output files, 0: original (default), 1: SOAP, 2: SAM'
    inputBinding:
      position: 101
      prefix: -f
  - id: mapq
    type:
      - 'null'
      - int
    doc: 'Set the MAPQ (mapping quality) field to this value, just valid in SAM format, 255 (default)'
    inputBinding:
      position: 101
      prefix: -s
  - id: quality_type
    type:
      - 'null'
      - int
    doc: 'Input quality type in FASTQ file. 0: Phred + 64 (default), 1: Phred + 33'
    inputBinding:
      position: 101
      prefix: -q
  - id: max_pair_distance
    type:
      - 'null'
      - int
    doc: 'The maximum distance between paired-end reads, 500000 (default)'
    inputBinding:
      position: 101
      prefix: -L
  - id: min_pair_distance
    type:
      - 'null'
      - int
    doc: 'The minimum distance between paired-end reads, 50 (default)'
    inputBinding:
      position: 101
      prefix: -l
  - id: insert_length
    type:
      - 'null'
      - int
    doc: 'The insert length of paired-end reads'
    inputBinding:
      position: 101
      prefix: -I
  - id: output_junctions
    type:
      - 'null'
      - int
    doc: '1: Output junction information (default), 0: Do not output junction information'
    inputBinding:
      position: 101
      prefix: -j
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Alignment and junction files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapsplice:1.10--2
