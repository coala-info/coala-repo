cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimfastq
label: slimfastq
doc: "Fast, memory-efficient FASTQ compressor and decompressor. With 'slimfastq A B',
  a FASTQ file A is compressed to B, and a slimfastq file A is decompressed to B (or to
  standard output when B is omitted).\n\nTool homepage: https://github.com/Infinidat/slimfastq"
inputs:
  - id: input_file
    type: ['null', File]
    doc: Input file A (a FASTQ file to compress, or a slimfastq file to decompress)
    inputBinding:
      position: 100
  - id: output_name
    type: ['null', string]
    doc: Output file name B (omit it to decompress to standard output)
    inputBinding:
      position: 101
  - id: user_file
    type: ['null', File]
    doc: Input (user) filename; default is standard input
    inputBinding:
      position: 1
      prefix: -u
  - id: compressed_file
    type: ['null', string]
    doc: Compressed filename; required when -u or standard input is used
    inputBinding:
      position: 1
      prefix: -f
  - id: decode
    type: ['null', boolean]
    doc: Decode (instead of encoding)
    inputBinding:
      position: 1
      prefix: -d
  - id: overwrite
    type: ['null', boolean]
    doc: Silently overwrite existing files
    inputBinding:
      position: 1
      prefix: -O
  - id: level
    type: ['null', int]
    doc: Compression level 1 to 4 (default is 3)
    inputBinding:
      position: 1
      prefix: -l
  - id: level_1
    type: ['null', boolean]
    doc: Alias for -l 1
    inputBinding:
      position: 1
      prefix: '-1'
  - id: level_2
    type: ['null', boolean]
    doc: Alias for -l 2
    inputBinding:
      position: 1
      prefix: '-2'
  - id: level_3
    type: ['null', boolean]
    doc: Alias for -l 3
    inputBinding:
      position: 1
      prefix: '-3'
  - id: level_4
    type: ['null', boolean]
    doc: Alias for -l 4
    inputBinding:
      position: 1
      prefix: '-4'
  - id: stat
    type: ['null', boolean]
    doc: Print information about a compressed file
    inputBinding:
      position: 1
      prefix: -s
  - id: quiet
    type: ['null', boolean]
    doc: Suppress extra stats info that could have been seen by -s
    inputBinding:
      position: 1
      prefix: -q
stdout: slimfastq_stdout.txt
stderr: slimfastq_stderr.txt
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output file B (compressed or decompressed)
    outputBinding:
      glob: |
        ${ var n = inputs.output_name || inputs.compressed_file; return n ? n : []; }
  - id: stdout_text
    type: File
    doc: Standard output (decompressed reads when B is omitted)
    outputBinding:
      glob: slimfastq_stdout.txt
  - id: stderr_text
    type: File
    doc: Standard error (the -s info report and run statistics)
    outputBinding:
      glob: slimfastq_stderr.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimfastq:2.04--h503566f_5
