cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyling align
label: phyling_align
doc: "Perform multiple sequence alignment (MSA) on orthologous sequences that match
  the hmm markers across samples.\n\nTool homepage: https://github.com/stajichlab/Phyling"
inputs:
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'Hmmsearch reporting threshold (default: 1e-10, only being used when bitscore
      cutoff file is not available)'
    default: '1e-10'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: input_dir
    type: Directory
    doc: Directory containing query pepetide/cds fasta or gzipped fasta
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: inputs
    type:
      type: array
      items: File
    doc: Query pepetide/cds fasta or gzipped fasta
    inputBinding:
      position: 101
      prefix: --inputs
  - id: markerset
    type: Directory
    doc: Directory of the HMM markerset
    inputBinding:
      position: 101
      prefix: --markerset
  - id: method
    type:
      - 'null'
      - string
    doc: 'Program used for multiple sequence alignment (default: hmmalign)'
    default: hmmalign
    inputBinding:
      position: 101
      prefix: --method
  - id: non_trim
    type:
      - 'null'
      - boolean
    doc: Report non-trimmed alignment results
    inputBinding:
      position: 101
      prefix: --non_trim
  - id: seqtype
    type:
      - 'null'
      - string
    doc: 'Input data sequence type (default: AUTO)'
    default: AUTO
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads for hmmsearch and the number of parallelized jobs in MSA step. Better
      be multiple of 4 if using more than 8 threads (default: 20)'
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: 'Output directory of the alignment results (default: phyling-align-[YYYYMMDD-HHMMSS]
      (UTC timestamp))'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
