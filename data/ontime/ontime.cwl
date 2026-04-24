cwlVersion: v1.2
class: CommandLineTool
baseCommand: ontime
label: ontime
doc: "Extract subsets of ONT (Nanopore) reads based on time\n\nTool homepage: https://github.com/mbhall88/ontime"
inputs:
  - id: input_file
    type: File
    doc: Input fastq/fasta/BAM/SAM file
    inputBinding:
      position: 1
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compression level to use if compressing fastq output
    inputBinding:
      position: 102
      prefix: --compress-level
  - id: from_time
    type:
      - 'null'
      - string
    doc: Earliest start time; otherwise the earliest time is used
    inputBinding:
      position: 102
      prefix: --from
  - id: output_type
    type:
      - 'null'
      - string
    doc: '(fastq/a output only) u: uncompressed; b: Bzip2; g: Gzip; l: Lzma'
    inputBinding:
      position: 102
      prefix: --output-type
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show the earliest and latest start times in the input and exit
    inputBinding:
      position: 102
      prefix: --show
  - id: to_time
    type:
      - 'null'
      - string
    doc: Latest start time; otherwise the latest time is used
    inputBinding:
      position: 102
      prefix: --to
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ontime:0.3.1--h031d066_0
