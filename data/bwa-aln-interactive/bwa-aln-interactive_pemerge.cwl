cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - pemerge
label: bwa-aln-interactive_pemerge
doc: "Merge paired-end reads\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: read1
    type: File
    doc: First read file (FQ)
    inputBinding:
      position: 1
  - id: read2
    type:
      - 'null'
      - File
    doc: Second read file (FQ)
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
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_pemerge.out
