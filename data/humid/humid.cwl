cwlVersion: v1.2
class: CommandLineTool
baseCommand: humid
label: humid
doc: "Deduplicate a dataset.\n\nTool homepage: https://github.com/jfjlaros/HUMID"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: FastQ files
    inputBinding:
      position: 1
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: allowed mismatches
    inputBinding:
      position: 102
      prefix: -m
  - id: calculate_statistics
    type:
      - 'null'
      - boolean
    doc: calculate statistics
    inputBinding:
      position: 102
      prefix: -s
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file name
    inputBinding:
      position: 102
      prefix: -l
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 102
      prefix: -d
  - id: use_edit_distance
    type:
      - 'null'
      - boolean
    doc: use edit distance
    inputBinding:
      position: 102
      prefix: -e
  - id: use_maximum_clustering
    type:
      - 'null'
      - boolean
    doc: use maximum clustering method
    inputBinding:
      position: 102
      prefix: -x
  - id: word_length
    type:
      - 'null'
      - int
    doc: word length
    inputBinding:
      position: 102
      prefix: -n
  - id: write_annotated_fastq
    type:
      - 'null'
      - boolean
    doc: write annotated FastQ files
    inputBinding:
      position: 102
      prefix: -a
  - id: write_deduplicated_fastq
    type:
      - 'null'
      - boolean
    doc: write deduplicated FastQ files
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humid:1.0.4--heae3180_2
stdout: humid.out
