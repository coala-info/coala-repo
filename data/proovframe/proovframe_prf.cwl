cwlVersion: v1.2
class: CommandLineTool
baseCommand: proovframe_prf
label: proovframe_prf
doc: "Assess error rate of a query sequence against a reference sequence.\n\nTool
  homepage: https://github.com/thackl/proovframe"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: query_fasta
    type: File
    doc: Query FASTA file
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show debug messages
    inputBinding:
      position: 103
      prefix: --debug
  - id: min_map_frac
    type:
      - 'null'
      - float
    doc: only assess seqs with at least this fraction aligned
    inputBinding:
      position: 103
      prefix: --min-map-frac
  - id: num_reads
    type:
      - 'null'
      - int
    doc: only assess first
    inputBinding:
      position: 103
      prefix: --num-reads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write to this file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
