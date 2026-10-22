cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - telo
label: seqtk_telo
doc: "Identify telomere repeats in assemblies or long reads\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: motif
    type:
      - 'null'
      - string
    doc: Telomere motif [CCCTAA]
    inputBinding:
      position: 102
      prefix: -m
  - id: penalty
    type:
      - 'null'
      - int
    doc: Penalty [1]
    inputBinding:
      position: 102
      prefix: -p
  - id: max_drop
    type:
      - 'null'
      - int
    doc: Max drop [2000]
    inputBinding:
      position: 102
      prefix: -d
  - id: min_score
    type:
      - 'null'
      - int
    doc: Min score [300]
    inputBinding:
      position: 102
      prefix: -s
  - id: print_scoring
    type:
      - 'null'
      - boolean
    doc: Print scoring
    inputBinding:
      position: 102
      prefix: -P
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_telo.out
