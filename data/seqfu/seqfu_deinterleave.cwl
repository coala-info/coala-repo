cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - dei
label: seqfu_deinterleave
doc: "Deinterleave a FASTQ file into two files (output_R1.fq and output_R2.fq)\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: interleaved_fastq
    type: File
    doc: Interleaved FASTQ file (use - to read from STDIN)
    inputBinding:
      position: 1
  - id: output_basename
    type: string
    doc: save output to output_R1.fq and output_R2.fq
    inputBinding:
      position: 102
      prefix: --output-basename
  - id: for_ext
    type:
      - 'null'
      - string
    doc: 'extension for R1 file [default: _R1.fq]'
    inputBinding:
      position: 102
      prefix: --for-ext
  - id: rev_ext
    type:
      - 'null'
      - string
    doc: 'extension for R2 file [default: _R2.fq]'
    inputBinding:
      position: 102
      prefix: --rev-ext
  - id: check
    type:
      - 'null'
      - boolean
    doc: enable careful mode (check sequence names and numbers)
    inputBinding:
      position: 102
      prefix: --check
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: skip comments
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: prefix
    type:
      - 'null'
      - string
    doc: rename sequences (append a progressive number)
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: forward_reads
    type:
      - 'null'
      - File
    doc: Forward reads file
    outputBinding:
      glob: '$(inputs.output_basename)$(inputs.for_ext ? inputs.for_ext : ''_R1.fq'')'
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: Reverse reads file
    outputBinding:
      glob: '$(inputs.output_basename)$(inputs.rev_ext ? inputs.rev_ext : ''_R2.fq'')'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_deinterleave.out
