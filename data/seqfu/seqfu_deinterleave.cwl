cwlVersion: v1.2
class: CommandLineTool
baseCommand: dei
label: seqfu_deinterleave
doc: "interleave FASTQ files\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: interleaved_fastq
    type: File
    doc: interleaved FASTQ file
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: enable careful mode (check sequence names and numbers)
    inputBinding:
      position: 102
      prefix: --check
  - id: output_basename
    type: string
    doc: save output to output_R1.fq and output_R2.fq
    inputBinding:
      position: 102
      prefix: --output-basename
  - id: prefix
    type:
      - 'null'
      - string
    doc: rename sequences (append a progressive number)
    inputBinding:
      position: 102
      prefix: --prefix
  - id: r1_extension
    type:
      - 'null'
      - string
    doc: extension for R1 file
    inputBinding:
      position: 102
      prefix: --for-ext
  - id: r2_extension
    type:
      - 'null'
      - string
    doc: extension for R2 file
    inputBinding:
      position: 102
      prefix: --rev-ext
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: skip comments
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_deinterleave.out
