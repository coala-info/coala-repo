cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligomap
label: oligomap
doc: "Finds matches of query sequences in a target sequence database.\n\nTool homepage:
  https://github.com/zavolanlab/oligomap"
inputs:
  - id: target_fa
    type: File
    doc: Target FASTA file
    inputBinding:
      position: 1
  - id: query_fa
    type: File
    doc: Query FASTA file
    inputBinding:
      position: 2
  - id: match_report_file
    type:
      - 'null'
      - File
    doc: create a match report at the end
    inputBinding:
      position: 103
      prefix: -r
  - id: max_hits
    type:
      - 'null'
      - int
    doc: maximum hits for one query to print
    inputBinding:
      position: 103
      prefix: -m
  - id: scan_directory
    type:
      - 'null'
      - boolean
    doc: scan all .fa target files in a directory (target must be a directory)
    inputBinding:
      position: 103
      prefix: -d
  - id: scan_plus_strand
    type:
      - 'null'
      - boolean
    doc: scan only plus strand of the target
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligomap:1.0.1--h077b44d_1
stdout: oligomap.out
