cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - scorereads
label: nanopolish_scorereads
doc: "Score reads against an alignment, model\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: calibrate
    type:
      - 'null'
      - boolean
    doc: recalibrate aligned reads to model before scoring
    inputBinding:
      position: 101
      prefix: --calibrate
  - id: genome
    type: File
    secondaryFiles:
      - .fai
    doc: the genome we are computing a consensus for is in FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: individual_reads
    type:
      - 'null'
      - string
    doc: optional comma-delimited list of readnames to score
    inputBinding:
      position: 101
      prefix: --individual-reads
  - id: models_fofn
    type:
      - 'null'
      - File
    doc: optionally use these models rather than models in fast5
    inputBinding:
      position: 101
      prefix: --models-fofn
  - id: reads
    type: File
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb
    doc: the ONT reads are in fasta FILE
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: train_transitions
    type:
      - 'null'
      - boolean
    doc: train new transition parameters from the input reads
    inputBinding:
      position: 101
      prefix: --train-transitions
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
    doc: 'score reads in the window STR (format: ctg:start-end)'
    inputBinding:
      position: 101
      prefix: --window
  - id: zero_drift
    type:
      - 'null'
      - boolean
    doc: if recalibrating, keep drift at 0
    inputBinding:
      position: 101
      prefix: --zero-drift
  - id: raw_ont_signal_directory
    type:
      type: array
      items: Directory
    doc: Directories with the raw ONT signal (fast5) files that were given to
      nanopolish index. They are staged in the working directory under the
      same names, so the relative fast5 paths stored in the reads index
      (.index.readdb) resolve.
  - id: model_files
    type:
      - 'null'
      - type: array
        items: File
    doc: k-mer model files named in the models_fofn file. They are staged in
      the working directory, so the names in the fofn resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.raw_ont_signal_directory)
      - entry: '$(inputs.model_files ? inputs.model_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_scorereads.out
