cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - merge-daa
label: diamond_merge-daa
doc: "Merge DAA files\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: input reference file in FASTA format/input DAA files for merge-daa
    inputBinding:
      position: 101
      prefix: --in
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
