cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyling
  - align
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
    inputBinding:
      position: 101
      prefix: --evalue
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing query pepetide/cds fasta or gzipped fasta
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Query pepetide/cds fasta or gzipped fasta
    inputBinding:
      position: 101
      prefix: --inputs
  - id: markerset
    type: Directory
    doc: Directory of the HMM markerset (the hmms folder of a BUSCO lineage)
    inputBinding:
      position: 101
      prefix: --markerset
      valueFrom: markerset_dir/hmms
  - id: scores_cutoff
    type: File
    doc: Bitscore cutoff file of the markerset (the scores_cutoff file next to the hmms
      folder; phyling reads it from the parent folder of the markerset)
  - id: method
    type:
      - 'null'
      - string
    doc: 'Program used for multiple sequence alignment (default: hmmalign)'
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
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads for hmmsearch and the number of parallelized jobs in MSA step. Better
      be multiple of 4 if using more than 8 threads (default: 20)'
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
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: 'Output directory of the alignment results (default: phyling-align-[YYYYMMDD-HHMMSS]
      (UTC timestamp))'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: markerset_dir/hmms
        entry: $(inputs.markerset)
        writable: true
      - entryname: markerset_dir/scores_cutoff
        entry: $(inputs.scores_cutoff)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
