cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - fastmap
label: bwa-aln-interactive_fastmap
doc: "Fastmap identifies Super Maximal Exact Matches (SMEMs) in sequences using a
  BWA index.\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: idxbase
    type: File
    doc: BWA index base file
    inputBinding:
      position: 1
  - id: in_fq
    type: File
    doc: Input fastq file
    inputBinding:
      position: 2
  - id: max_interval_size
    type:
      - 'null'
      - int
    doc: max interval size to find coordiantes
    default: 20
    inputBinding:
      position: 103
      prefix: -w
  - id: max_mem_length
    type:
      - 'null'
      - int
    doc: max MEM length
    default: 2147483647
    inputBinding:
      position: 103
      prefix: -L
  - id: min_smem_interval
    type:
      - 'null'
      - int
    doc: min SMEM interval size
    default: 1
    inputBinding:
      position: 103
      prefix: -i
  - id: min_smem_length
    type:
      - 'null'
      - int
    doc: min SMEM length to output
    default: 17
    inputBinding:
      position: 103
      prefix: -l
  - id: stop_mem_threshold
    type:
      - 'null'
      - int
    doc: stop if MEM is longer than -l with a size less than INT
    default: 0
    inputBinding:
      position: 103
      prefix: -I
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_fastmap.out
