cwlVersion: v1.2
class: CommandLineTool
baseCommand: yacrd
label: yacrd_filter
doc: "Record mark as chimeric or NotCovered is filter\n\nTool homepage: https://github.com/natir/yacrd"
inputs:
  - id: overlap_input
    type: File
    doc: path to input file overlap (.paf|.m4|.mhap) or yacrd report (.yacrd), format is autodetected and compression input is allowed (gz|bzip2|lzma)
    inputBinding:
      position: 1
      prefix: --input
  - id: report_output
    type: string
    doc: path of the yacrd report output file
    inputBinding:
      position: 2
      prefix: --output
  - id: coverage
    type:
      - 'null'
      - int
    doc: if coverage reach this value region is marked as bad
    inputBinding:
      position: 3
      prefix: --coverage
  - id: not_coverage
    type:
      - 'null'
      - float
    doc: if the ratio of bad region length on total length is lower than this value, read is marked as NotCovered
    inputBinding:
      position: 4
      prefix: --not-coverage
  - id: thread
    type:
      - 'null'
      - int
    doc: number of thread use by yacrd, 0 mean all threads available, default 1
    inputBinding:
      position: 5
      prefix: --thread
  - id: ondisk
    type:
      - 'null'
      - string
    doc: yacrd switches to 'ondisk' mode which will reduce memory usage but increase computation time. The value passed as a parameter is used as a prefix for the temporary files created by yacrd. Be careful if the prefix contains path separators this folder will be deleted
    inputBinding:
      position: 6
      prefix: --ondisk
  - id: ondisk_buffer_size
    type:
      - 'null'
      - int
    doc: with the default value yacrd in 'ondisk' mode use around 1 GBytes, you can increase to reduce runtime but increase memory usage
    inputBinding:
      position: 7
      prefix: --ondisk-buffer-size
  - id: read_buffer_size
    type:
      - 'null'
      - int
    doc: Control the size of the buffer used to read paf file
    inputBinding:
      position: 8
      prefix: --read-buffer-size
  - id: input
    type: File
    doc: path to sequence input (fasta|fastq), compression is autodetected (none|gzip|bzip2|lzma)
    inputBinding:
      position: 11
      prefix: --input
  - id: output_path
    type: string
    doc: path to output file, format and compression of input is preserved
    inputBinding:
      position: 12
      prefix: --output
arguments:
  - position: 10
    valueFrom: filter
outputs:
  - id: report
    type: File
    doc: yacrd report (one line per read with its bad regions)
    outputBinding:
      glob: $(inputs.report_output)
  - id: output
    type: File
    doc: path to output file, format and compression of input is preserved
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
