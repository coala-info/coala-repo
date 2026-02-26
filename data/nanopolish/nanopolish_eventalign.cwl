cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - eventalign
label: nanopolish_eventalign
doc: "Align nanopore events to reference k-mers\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: bam
    type: File
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: genome
    type: File
    doc: the genome we are computing a consensus for is in FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'only use reads with mapping quality at least NUM (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: models_fofn
    type:
      - 'null'
      - File
    doc: read alternative k-mer models from FILE
    inputBinding:
      position: 101
      prefix: --models-fofn
  - id: print_read_names
    type:
      - 'null'
      - boolean
    doc: print read names instead of indexes
    inputBinding:
      position: 101
      prefix: --print-read-names
  - id: progress
    type:
      - 'null'
      - boolean
    doc: print out a progress message
    inputBinding:
      position: 101
      prefix: --progress
  - id: reads
    type: File
    doc: the ONT reads are in fasta FILE
    inputBinding:
      position: 101
      prefix: --reads
  - id: sam_format
    type:
      - 'null'
      - boolean
    doc: write output in SAM format
    inputBinding:
      position: 101
      prefix: --sam
  - id: samples
    type:
      - 'null'
      - boolean
    doc: write the raw samples for the event to the tsv output
    inputBinding:
      position: 101
      prefix: --samples
  - id: scale_events
    type:
      - 'null'
      - boolean
    doc: scale events to the model, rather than vice-versa
    inputBinding:
      position: 101
      prefix: --scale-events
  - id: signal_index
    type:
      - 'null'
      - boolean
    doc: write the raw signal start and end index values for the event to the 
      tsv output
    inputBinding:
      position: 101
      prefix: --signal-index
  - id: summary
    type:
      - 'null'
      - File
    doc: summarize the alignment of each read/strand in FILE
    inputBinding:
      position: 101
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - string
    doc: 'compute the consensus for window STR (format: ctg:start_id-end_id)'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_eventalign.out
