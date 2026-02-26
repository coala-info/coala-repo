cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-calling
label: fermikit_run-calling
doc: "Calling\n\nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: indexed_ref
    type: File
    doc: indexed reference
    inputBinding:
      position: 1
  - id: unitigs_mag_gz
    type: File
    doc: unitigs.mag.gz
    inputBinding:
      position: 2
  - id: bwa_index_prefix
    type:
      - 'null'
      - string
    doc: prefix for BWA index
    inputBinding:
      position: 103
      prefix: -b
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output files
    inputBinding:
      position: 103
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 4
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_run-calling.out
