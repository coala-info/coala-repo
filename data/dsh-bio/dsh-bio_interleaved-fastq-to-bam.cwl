cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dsh-interleaved-fastq-to-bam
label: dsh-bio_interleaved-fastq-to-bam
doc: "Convert interleaved paired-end FASTQ format to unaligned BAM format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input interleaved FASTQ path, default stdin
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: output_bam_file
    type: string
    default: output.bam
    doc: output BAM file, default stdout
    inputBinding:
      position: 101
      prefix: --output-bam-file
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: read group id
    inputBinding:
      position: 101
      prefix: --read-group-id
  - id: read_group_sample
    type:
      - 'null'
      - string
    doc: read group sample
    inputBinding:
      position: 101
      prefix: --read-group-sample
  - id: read_group_library
    type:
      - 'null'
      - string
    doc: read group library
    inputBinding:
      position: 101
      prefix: --read-group-library
  - id: read_group_platform_unit
    type:
      - 'null'
      - string
    doc: read group platform unit
    inputBinding:
      position: 101
      prefix: --read-group-platform-unit
  - id: read_group_insert_size
    type:
      - 'null'
      - int
    doc: read group predicted median insert size
    inputBinding:
      position: 101
      prefix: --read-group-insert-size
  - id: read_group_barcodes
    type:
      - 'null'
      - type: array
        items: string
    doc: read group barcodes (comma-separated list)
    inputBinding:
      position: 101
      prefix: --read-group-barcodes
      itemSeparator: ','
outputs:
  - id: output_bam
    type: File
    doc: output unaligned BAM file
    outputBinding:
      glob: $(inputs.output_bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
