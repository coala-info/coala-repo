cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_annotations.py
label: getorganelle_check_annotations.py
doc: "This script only checks the mainly check the reliability of automatically annotated tRNA and CDS.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: query_gb_files
    type:
      - type: array
        items: File
    doc: "Input a list of *.gb files as the query."
    inputBinding:
      position: 1
  - id: reference_gb
    type:
      - 'null'
      - File
    doc: "Input reference *.gb file."
    inputBinding:
      position: 101
      prefix: "-r"
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: "Input reference fasta file exported by \"Extract Annotations\"-\"Export\"-\"Selected Documents\"-fasta in Geneious, with \"Replace spaces in sequence name with underscores\" chosen (alternative to -r)."
    inputBinding:
      position: 101
      prefix: "-d"
  - id: trna_ends
    type:
      - 'null'
      - int
    doc: "The length to check at the both ends of tRNA. Default=10."
    inputBinding:
      position: 101
      prefix: "--t-ends"
  - id: cds_ends
    type:
      - 'null'
      - int
    doc: "Activate this calculation and assign the length to check at the both ends of CDS. Default: not activated."
    inputBinding:
      position: 101
      prefix: "--c-ends"
  - id: all_ends
    type:
      - 'null'
      - int
    doc: "Activate this calculation and assign the length to check at the both ends of annotated all regions. Default: not activated."
    inputBinding:
      position: 101
      prefix: "--a-ends"
  - id: length_threshold
    type:
      - 'null'
      - float
    doc: "Length threshold to report warning. Default=0.9."
    inputBinding:
      position: 101
      prefix: "--l-threshold"
  - id: similarity
    type:
      - 'null'
      - boolean
    doc: "Choose to enable similarity calculation. Default=False."
    inputBinding:
      position: 101
      prefix: "--similarity"
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: "Similarity threshold to report warning. Should be < length threshold. Default=0.9."
    inputBinding:
      position: 101
      prefix: "--s-threshold"
outputs:
  - id: check_logs
    type:
      type: array
      items: File
    doc: "Check log written beside each query file."
    outputBinding:
      glob: "*.check.log"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.query_gb_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_check_annotations.py.out
