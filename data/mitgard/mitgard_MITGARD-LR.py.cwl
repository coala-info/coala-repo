cwlVersion: v1.2
class: CommandLineTool
baseCommand: MITGARD-LR.py
label: mitgard_MITGARD-LR.py
doc: "MITGARD-LR.py\n\nTool homepage: https://github.com/pedronachtigall/MITGARD"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: Optional - number of threads to be used in each step
    inputBinding:
      position: 101
      prefix: --cpu
  - id: length
    type:
      - 'null'
      - int
    doc: "Optional - this parameter indicates the estimated size\n               \
      \         of the final mitochondiral genome (in bp; e.g., use\n            \
      \            17000 for 17Kb). If not set, the estimated size will\n        \
      \                be considered similar to the reference being used."
    inputBinding:
      position: 101
      prefix: --length
  - id: method
    type:
      - 'null'
      - string
    doc: "Optional - this parameter indicates the type of long-\n                \
      \        read data being used (e.g., \"pacbio_hifi\",\n                    \
      \    \"pacbio_clr\", or \"nanopore\"). If not set, the\n                   \
      \     \"pacbio_hifi\" will be considered."
    inputBinding:
      position: 101
      prefix: --method
  - id: reads
    type: File
    doc: "Mandatory - input long-reads fq file (FASTQ format),\n                 \
      \       /path/to/long_read.fq ; the fq file can be in .gz the\n            \
      \            compressed format (e.g. long_read.fq.gz)."
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: "Mandatory - input mitogenome in FASTA format to be\n                   \
      \     used as reference, /path/to/reference.fa"
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_id
    type: string
    doc: "Mandatory - sample ID to be used in the output files\n                 \
      \       and final mitogenome assembly"
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
stdout: mitgard_MITGARD-LR.py.out
