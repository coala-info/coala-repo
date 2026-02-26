cwlVersion: v1.2
class: CommandLineTool
baseCommand: ilv
label: seqfu_interleave
doc: "interleave FASTQ files\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: check
    type:
      - 'null'
      - boolean
    doc: enable careful mode (check sequence names and numbers)
    inputBinding:
      position: 101
      prefix: --check
  - id: forward_pair
    type: File
    doc: forward files
    inputBinding:
      position: 101
      prefix: --for-tag
  - id: prefix
    type:
      - 'null'
      - string
    doc: rename sequences (append a progressive number)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reverse_pair
    type:
      - 'null'
      - File
    doc: reverse files
    inputBinding:
      position: 101
      prefix: --rev-tag
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: skip comments
    inputBinding:
      position: 101
      prefix: --strip-comments
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outputfile
    type:
      - 'null'
      - File
    doc: save file to <out-file> instead of STDOUT
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
