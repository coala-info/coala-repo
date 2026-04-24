cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalt_sample
label: smalt_sample
doc: "Sample reads from query files based on an index.\n\nTool homepage: https://github.com/roquie/smalte"
inputs:
  - id: index_name
    type: string
    doc: Name of the SMALT index
    inputBinding:
      position: 1
  - id: query_file
    type: File
    doc: Query file (FASTQ, SAM, or BAM)
    inputBinding:
      position: 2
  - id: mate_file
    type:
      - 'null'
      - File
    doc: Optional mate file (FASTQ, SAM, or BAM)
    inputBinding:
      position: 3
  - id: alignment_score_threshold
    type:
      - 'null'
      - int
    doc: Threshold of the alignment score
    inputBinding:
      position: 104
      prefix: -m
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: Base quality threshold <= 10
    inputBinding:
      position: 104
      prefix: -q
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format [fastq (default)|sam|bam]
    inputBinding:
      position: 104
      prefix: -F
  - id: sample_every_nreads
    type:
      - 'null'
      - int
    doc: Map only every <nreads>-th read pair
    inputBinding:
      position: 104
      prefix: -u
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Write temporary files to specified directory
    inputBinding:
      position: 104
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Run multi-threaded with this number of threads
    inputBinding:
      position: 104
      prefix: -n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Write output to specified file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
