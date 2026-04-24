cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - mergefa
label: seqtk_mergefa
doc: "Merge two FASTA/Q files\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: in1_fa
    type: File
    doc: First input FASTA file
    inputBinding:
      position: 1
  - id: in2_fa
    type: File
    doc: Second input FASTA file
    inputBinding:
      position: 2
  - id: convert_lowercase
    type:
      - 'null'
      - boolean
    doc: convert to lowercase when one of the input base is N
    inputBinding:
      position: 103
      prefix: -m
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: quality threshold
    inputBinding:
      position: 103
      prefix: -q
  - id: random_allele
    type:
      - 'null'
      - boolean
    doc: pick a random allele from het
    inputBinding:
      position: 103
      prefix: -r
  - id: suppress_hets
    type:
      - 'null'
      - boolean
    doc: suppress hets in the input
    inputBinding:
      position: 103
      prefix: -h
  - id: take_intersection
    type:
      - 'null'
      - boolean
    doc: take intersection
    inputBinding:
      position: 103
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_mergefa.out
