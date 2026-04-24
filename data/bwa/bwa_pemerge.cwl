cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - pemerge
label: bwa_pemerge
doc: "Merge paired-end reads from BWA\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: read1_fq
    type: File
    doc: First read input file (FQ format)
    inputBinding:
      position: 1
  - id: read2_fq
    type:
      - 'null'
      - File
    doc: Second read input file (FQ format)
    inputBinding:
      position: 2
  - id: max_errors
    type:
      - 'null'
      - int
    doc: max sum of errors
    inputBinding:
      position: 103
      prefix: -Q
  - id: merged_only
    type:
      - 'null'
      - boolean
    doc: output merged reads only
    inputBinding:
      position: 103
      prefix: -m
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum end overlap
    inputBinding:
      position: 103
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
  - id: unmerged_only
    type:
      - 'null'
      - boolean
    doc: output unmerged reads only
    inputBinding:
      position: 103
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
stdout: bwa_pemerge.out
