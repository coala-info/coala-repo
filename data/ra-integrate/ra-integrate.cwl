cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/ra-integrate
label: ra-integrate
doc: "ra-integrate\n\nTool homepage: https://github.com/mediavrog/integrated-rating-request"
inputs:
  - id: fasta_reads
    type: File
    doc: fasta_reads
    inputBinding:
      position: 1
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Set given dirpath as working directory
    inputBinding:
      position: 102
      prefix: --directory
  - id: overlaps_file
    type:
      - 'null'
      - File
    doc: Skip overlap phase and use overlaps from given file
    inputBinding:
      position: 102
      prefix: --overlaps
  - id: spec_file
    type:
      - 'null'
      - File
    doc: Set given spec file
    inputBinding:
      position: 102
      prefix: --spec
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra-integrate:0.1--0
stdout: ra-integrate.out
