cwlVersion: v1.2
class: CommandLineTool
baseCommand: bazam
label: bazam
doc: "Bazam is a tool to extract paired reads from a coordinate-sorted BAM file and
  output them as FASTQ, suitable for piping into a new alignment.\n\nTool homepage:
  https://github.com/ssadedin/bazam"
inputs:
  - id: bam
    type: File
    doc: BAM file to extract read pairs from
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: -bam
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Concurrency parameter (4)
    inputBinding:
      position: 101
      prefix: -n
  - id: name_pos
    type:
      - 'null'
      - boolean
    doc: Add original position to the read names
    inputBinding:
      position: 101
      prefix: -namepos
  - id: pad
    type:
      - 'null'
      - int
    doc: Amount to pad regions by (0)
    inputBinding:
      position: 101
      prefix: -pad
  - id: regions
    type:
      - 'null'
      - string
    doc: Regions to include reads (and mates of reads) from
    inputBinding:
      position: 101
      prefix: -L
  - id: regions_file
    type:
      - 'null'
      - File
    doc: BED file of regions to include reads (and mates of reads) from
    inputBinding:
      position: 101
      prefix: -L
  - id: gene
    type:
      - 'null'
      - string
    doc: Extract region of given gene
    inputBinding:
      position: 101
      prefix: -gene
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter using specified groovy expression
    inputBinding:
      position: 101
      prefix: -f
  - id: shard
    type:
      - 'null'
      - string
    doc: 'Sharding factor: format <n>,<N>: output only reads belonging to shard n of N'
    inputBinding:
      position: 101
      prefix: -s
  - id: fastq_output_path
    type:
      - 'null'
      - string
    doc: Output file (interleaved FASTQ)
    inputBinding:
      position: 102
      prefix: -o
  - id: r1_output_path
    type:
      - 'null'
      - string
    doc: Output for R1 if extracting FASTQ in separate files
    inputBinding:
      position: 102
      prefix: -r1
  - id: r2_output_path
    type:
      - 'null'
      - string
    doc: Output for R2 if extracting FASTQ in separate files
    inputBinding:
      position: 102
      prefix: -r2
outputs:
  - id: fastq_output
    type:
      - 'null'
      - File
    doc: Interleaved FASTQ output file
    outputBinding:
      glob: $(inputs.fastq_output_path)
  - id: r1_output
    type:
      - 'null'
      - File
    doc: R1 FASTQ output file
    outputBinding:
      glob: $(inputs.r1_output_path)
  - id: r2_output
    type:
      - 'null'
      - File
    doc: R2 FASTQ output file
    outputBinding:
      glob: $(inputs.r2_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bazam:1.0.1--0
