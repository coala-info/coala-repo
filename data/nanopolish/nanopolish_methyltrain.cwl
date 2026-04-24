cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - methyltrain
label: nanopolish_methyltrain
doc: "Train a methylation model\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: bam
    type: File
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: calibrate
    type:
      - 'null'
      - boolean
    doc: recalibrate aligned reads to model before training
    inputBinding:
      position: 101
      prefix: --calibrate
  - id: filter_policy
    type:
      - 'null'
      - string
    doc: filter reads for [R7] or [R9] project
    inputBinding:
      position: 101
      prefix: --filter-policy
  - id: genome
    type: File
    doc: the reference genome is in FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: max_events
    type:
      - 'null'
      - int
    doc: 'use NUM events for training (default: 1000)'
    inputBinding:
      position: 101
      prefix: --max-events
  - id: max_reads
    type:
      - 'null'
      - int
    doc: stop after processing NUM reads in each round
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: models_fofn
    type:
      - 'null'
      - File
    doc: read the models to be trained from the FOFN
    inputBinding:
      position: 101
      prefix: --models-fofn
  - id: no_update_models
    type:
      - 'null'
      - boolean
    doc: do not write out trained models
    inputBinding:
      position: 101
      prefix: --no-update-models
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: name output files like <strand>.out_suffix
    inputBinding:
      position: 101
      prefix: --out-suffix
  - id: output_scores
    type:
      - 'null'
      - boolean
    doc: optionally output read scores during training
    inputBinding:
      position: 101
      prefix: --output-scores
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
  - id: rounds
    type:
      - 'null'
      - int
    doc: number of training rounds to perform
    inputBinding:
      position: 101
      prefix: --rounds
  - id: stdv
    type:
      - 'null'
      - boolean
    doc: enable stdv modelling
    inputBinding:
      position: 101
      prefix: --stdv
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: train_kmers
    type:
      - 'null'
      - string
    doc: train methylated, unmethylated or all kmers
    inputBinding:
      position: 101
      prefix: --train-kmers
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_fofn
    type:
      - 'null'
      - File
    doc: write the names of the output models into FILE
    outputBinding:
      glob: $(inputs.out_fofn)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
