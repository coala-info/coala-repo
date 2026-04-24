cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastuniq
label: fastuniq
doc: "FastUniq is a fast de-duplication tool for short reads from Next-Generation
  Sequencing. It identifies and removes duplicate reads from paired-end or single-end
  FASTQ files.\n\nTool homepage: https://github.com/matsuoka-601/FastUniq"
inputs:
  - id: compression_type
    type:
      - 'null'
      - int
    doc: 'Compression type for output files: 0 for no compression, 1 for gzip, 2 for
      bzip2.'
    inputBinding:
      position: 101
      prefix: -c
  - id: fastq_format
    type:
      - 'null'
      - string
    doc: Whether to output in FASTQ format ('t' for true, 'f' for false).
    inputBinding:
      position: 101
      prefix: -t
  - id: input_list
    type: File
    doc: Input list of FASTQ files. For paired-end data, each line should 
      contain two file names separated by a space or tab.
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_1
    type: File
    doc: Output file for the first read of paired-end data or for single-end 
      data.
    outputBinding:
      glob: $(inputs.output_1)
  - id: output_2
    type:
      - 'null'
      - File
    doc: Output file for the second read of paired-end data.
    outputBinding:
      glob: $(inputs.output_2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastuniq:1.1--h7b50bb2_2
