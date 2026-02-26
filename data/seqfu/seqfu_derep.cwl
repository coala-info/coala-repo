cwlVersion: v1.2
class: CommandLineTool
baseCommand: derep
label: seqfu_derep
doc: "Dereplicate sequences based on their content.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA/FASTQ files
    inputBinding:
      position: 1
  - id: add_len
    type:
      - 'null'
      - boolean
    doc: Add length to sequence
    inputBinding:
      position: 102
      prefix: --add-len
  - id: ignore_size
    type:
      - 'null'
      - boolean
    doc: Do not count 'size=INT;' annotations (they will be stripped in any 
      case)
    inputBinding:
      position: 102
      prefix: --ignore-size
  - id: keep_name
    type:
      - 'null'
      - boolean
    doc: Do not rename sequence (see -p), but use the first sequence name
    inputBinding:
      position: 102
      prefix: --keep-name
  - id: line_width
    type:
      - 'null'
      - int
    doc: 'FASTA line width (0: unlimited)'
    default: 0
    inputBinding:
      position: 102
      prefix: --line-width
  - id: max_length
    type:
      - 'null'
      - int
    doc: Discard sequences longer than MAX_LEN
    default: 0
    inputBinding:
      position: 102
      prefix: --max-length
  - id: md5
    type:
      - 'null'
      - boolean
    doc: Use MD5 as sequence name (overrides other parameters)
    inputBinding:
      position: 102
      prefix: --md5
  - id: min_length
    type:
      - 'null'
      - int
    doc: Discard sequences shorter than MIN_LEN
    default: 0
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_size
    type:
      - 'null'
      - int
    doc: Print clusters with size equal or bigger than INT sequences
    default: 0
    inputBinding:
      position: 102
      prefix: --min-size
  - id: prefix
    type:
      - 'null'
      - string
    doc: Sequence name prefix
    default: seq
    inputBinding:
      position: 102
      prefix: --prefix
  - id: separator
    type:
      - 'null'
      - string
    doc: Sequence name separator
    default: .
    inputBinding:
      position: 102
      prefix: --separator
  - id: size_as_comment
    type:
      - 'null'
      - boolean
    doc: Print cluster size as comment, not in sequence name
    inputBinding:
      position: 102
      prefix: --size-as-comment
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: json_file
    type:
      - 'null'
      - File
    doc: Save dereplication metadata to JSON file
    outputBinding:
      glob: $(inputs.json_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
