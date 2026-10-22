cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smalt
  - sample
label: smalt_sample
doc: "Sample reads from query files based on an index.\n\nTool homepage: https://www.sanger.ac.uk/tool/smalt-0/"
inputs:
  - id: index_name
    type: string
    doc: Name of the SMALT index
    inputBinding:
      position: 102
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files (<index_name>.sma and <index_name>.smi) made by smalt index. 
      They are staged in the working directory so that index_name resolves.
  - id: query_file
    type: File
    doc: Query file (FASTQ, SAM, or BAM)
    inputBinding:
      position: 103
  - id: mate_file
    type:
      - 'null'
      - File
    doc: Optional mate file (FASTQ, SAM, or BAM)
    inputBinding:
      position: 104
  - id: alignment_score_threshold
    type:
      - 'null'
      - int
    doc: Threshold of the alignment score
    inputBinding:
      position: 101
      prefix: -m
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: Base quality threshold <= 10
    inputBinding:
      position: 101
      prefix: -q
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format [fastq (default)|sam|bam]
    inputBinding:
      position: 101
      prefix: -F
  - id: sample_every_nreads
    type:
      - 'null'
      - int
    doc: Map only every <nreads>-th read pair
    inputBinding:
      position: 101
      prefix: -u
  - id: temporary_directory
    type:
      - 'null'
      - string
    doc: Write temporary files to specified directory
    inputBinding:
      position: 101
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Run multi-threaded with this number of threads
    inputBinding:
      position: 101
      prefix: -n
  - id: output_file_path
    type: string
    doc: '[STR] Write output to specified file (default: stdout).'
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Write output to specified file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
