cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerStreamJoin
label: kmerstream_KmerStreamJoin
doc: "Creates union of many stream estimates\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Output files
    inputBinding:
      position: 1
  - id: merged_file
    type:
      - 'null'
      - File
    doc: Merged file
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print output at the end
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Filename for output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
