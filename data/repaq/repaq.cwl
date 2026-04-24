cwlVersion: v1.2
class: CommandLineTool
baseCommand: repaq
label: repaq
doc: "repack FASTQ to a smaller binary file (.rfq)\n\nTool homepage: https://github.com/OpenGene/repaq"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: the chunk size (kilo bases) for encoding
    inputBinding:
      position: 101
      prefix: --chunk
  - id: compare
    type:
      - 'null'
      - boolean
    doc: compare the files read by read to check the compression consistency. 
      <rfq_to_compare> should be specified in this mode.
    inputBinding:
      position: 101
      prefix: --compare
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress input to output
    inputBinding:
      position: 101
      prefix: --compress
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level. Higher level means higher compression ratio, and 
      more RAM usage (1~9)
    inputBinding:
      position: 101
      prefix: --compression
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress input to output
    inputBinding:
      position: 101
      prefix: --decompress
  - id: fast_verify
    type:
      - 'null'
      - boolean
    doc: only verify part (10%) of the output stream to save time.
    inputBinding:
      position: 101
      prefix: --fast_verify
  - id: input_file1
    type:
      - 'null'
      - string
    doc: input file name
    inputBinding:
      position: 101
      prefix: --in1
  - id: input_file2
    type:
      - 'null'
      - string
    doc: read2 input file name when encoding paired-end FASTQ files
    inputBinding:
      position: 101
      prefix: --in2
  - id: interleaved_in
    type:
      - 'null'
      - boolean
    doc: indicate that <in1> is an interleaved paired-end FASTQ which contains 
      both read1 and read2. Disabled by defaut.
    inputBinding:
      position: 101
      prefix: --interleaved_in
  - id: rfq_to_compare
    type:
      - 'null'
      - string
    doc: the RFQ file to be compared with the input. This option is only used in
      compare mode.
    inputBinding:
      position: 101
      prefix: --rfq_to_compare
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: input from STDIN. If the STDIN is interleaved paired-end FASTQ, please 
      also add --interleaved_in.
    inputBinding:
      position: 101
      prefix: --stdin
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: write to STDOUT. When decompressing PE data, this option will result in
      interleaved FASTQ output for paired-end input. Disabled by defaut.
    inputBinding:
      position: 101
      prefix: --stdout
  - id: thread
    type:
      - 'null'
      - int
    doc: thread number for xz compression. Higher thread num means higher speed 
      and lower compression ratio (1~16)
    inputBinding:
      position: 101
      prefix: --thread
  - id: verify
    type:
      - 'null'
      - boolean
    doc: verify the output stream to ensure compression is correct.
    inputBinding:
      position: 101
      prefix: --verify
outputs:
  - id: output_file1
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file1)
  - id: output_file2
    type:
      - 'null'
      - File
    doc: read2 output file name when decoding to paired-end FASTQ files
    outputBinding:
      glob: $(inputs.output_file2)
  - id: json_compare_result
    type:
      - 'null'
      - File
    doc: the file to store the comparison result. This is optional since the 
      result is also printed on STDOUT.
    outputBinding:
      glob: $(inputs.json_compare_result)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repaq:0.5.1--hcb620b3_1
