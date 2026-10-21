cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - sdfsubset
label: rtg-tools_rtg_sdfsubset
doc: 'Extracts a subset of sequences from one SDF and outputs them to another SDF. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: Directory
    doc: 'SDF containing sequences'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output SDF'
    inputBinding:
      position: 101
      prefix: --output
  - id: end_id
    type:
      - 'null'
      - int
    doc: 'exclusive upper bound on sequence id'
    inputBinding:
      position: 101
      prefix: --end-id
  - id: id_file
    type:
      - 'null'
      - File
    doc: 'file containing sequence ids, or sequence names if --names flag is set, one per line'
    inputBinding:
      position: 101
      prefix: --id-file
  - id: names
    type:
      - 'null'
      - boolean
    doc: 'interpret supplied sequence as names instead of numeric ids'
    inputBinding:
      position: 101
      prefix: --names
  - id: start_id
    type:
      - 'null'
      - int
    doc: 'inclusive lower bound on sequence id'
    inputBinding:
      position: 101
      prefix: --start-id
  - id: sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: 'id of sequence to extract, or sequence name if --names flag is set. May be specified 0 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sdf
    type: Directory
    doc: 'Output SDF directory'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_sdfsubset.out
